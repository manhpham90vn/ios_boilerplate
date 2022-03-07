//
//  ApiConnection.swift
//  VIPPER
//
//  Created by Manh Pham on 3/16/21.
//

import Resolver
import Moya
import RxSwift
import RxCocoa
import RxMoya

final class ApiConnection {

    @Injected var getTokenUseCaseInterface: GETTokenUseCaseInterface
    private var apiProvider: ApiProvider<MultiTarget>!

    static let shared = ApiConnection()
    private init() {}

    private func makeProvider() -> ApiProvider<MultiTarget> {
        var plugins = [PluginType]()

        plugins.append(NetworkIndicatorPlugin.indicatorPlugin())

        if let token = getTokenUseCaseInterface.getToken() {
            let tokenClosure: (TargetType) -> String = { _ in
                return token
            }
            let authPlugin = AccessTokenPlugin(tokenClosure: tokenClosure)
            plugins.append(authPlugin)
        }

        if Configs.shared.loggingAPIEnabled {
            plugins.append(NetworkLoggerPlugin(configuration: .init(logOptions: .verbose)))
        }
        let apiProvider = ApiProvider<MultiTarget>(plugins: plugins)
        self.apiProvider = apiProvider // need this to keep strong reference
        return apiProvider
    }
}

extension ApiConnection {

    func request<T: Codable>(target: MultiTarget, type: T.Type) -> Single<T> {
        return makeProvider().request(target: target).map(T.self)
    }

    func requestArray<T: Codable>(target: MultiTarget, type: T.Type) -> Single<[T]> {
        return makeProvider().request(target: target).map([T].self)
    }

}
