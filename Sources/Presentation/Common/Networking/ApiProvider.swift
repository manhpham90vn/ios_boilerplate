//
//  ApiProvider.swift
//  VIPPER
//
//  Created by Manh Pham on 3/16/21.
//

import RxSwift
import RxCocoa
import Moya
import Alamofire

final class ApiProvider<Target: TargetType>: MoyaProvider<Target> {
    
    init(plugins: [PluginType]) {
        super.init(plugins: plugins)
    }
    
    func request(target: Target) -> Single<Response> {
        return rx
            .request(target)
            .filterSuccessfulStatusCodes()
            .autoRetry(delay: .constant(time: 1), shouldRetry: { _ -> Bool in
                guard let autoRetry = (target as? MultiTarget)?.target as? Retryable else { return false }
                return autoRetry.autoRetry
            })
    }
}
