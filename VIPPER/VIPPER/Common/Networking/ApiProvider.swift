//
//  ApiProvider.swift
//  VIPPER
//
//  Created by Manh Pham on 3/16/21.
//

import Foundation
import Moya
import RxSwift

final class ApiProvider<Target: TargetType>: MoyaProvider<Target> {
    
    init(plugins: [PluginType]) {
        var plugins = plugins
        plugins.append(NetworkIndicatorPlugin.indicatorPlugin())
        if Configs.shared.loggingEnabled {
            plugins.append(NetworkLoggerPlugin(configuration: .init(logOptions: .verbose)))
        }
        super.init(plugins: plugins)
    }
            
    func request(target: Target) -> Single<Response> {
        return connectedToInternet()
            .timeout(Configs.shared.apiTimeOut, scheduler: MainScheduler.instance)
            .filter({ $0 == true })
            .take(1)
            .flatMap({ _ in
                return self
                    .rx
                    .request(target)
                    .timeout(Configs.shared.apiTimeOut, scheduler: MainScheduler.instance)
            })
            .observeOn(MainScheduler.instance)
            .asSingle()
    }
        
}
