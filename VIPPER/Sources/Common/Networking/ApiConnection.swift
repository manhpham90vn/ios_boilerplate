//
//  ApiConnection.swift
//  VIPPER
//
//  Created by Manh Pham on 3/16/21.
//

final class ApiConnection {

    @Inject var authManager: AuthManagerInterface

    static let shared = ApiConnection()
    private init() {}

    private func makeProvider() -> ApiProvider<MultiTarget> {
        var plugins = [PluginType]()

        plugins.append(NetworkIndicatorPlugin.indicatorPlugin())

        if let token = authManager.token {
            let tokenClosure: (AuthorizationType) -> String = { _ in
                return token
            }
            let authPlugin = AccessTokenPlugin(tokenClosure: tokenClosure)
            plugins.append(authPlugin)
        }

        if Configs.shared.loggingEnabled {
            plugins.append(NetworkLoggerPlugin(configuration: .init(logOptions: .verbose)))
        }
        let apiProvider = ApiProvider<MultiTarget>(plugins: plugins)
        return apiProvider
    }
}

extension ApiConnection {

    func request<T: Codable>(target: MultiTarget, type: T.Type) -> Observable<T> {
        return makeProvider().request(target: target).map(T.self)
    }

    func requestArray<T: Codable>(target: MultiTarget, type: T.Type) -> Observable<[T]> {
        return makeProvider().request(target: target).map([T].self)
    }

}
