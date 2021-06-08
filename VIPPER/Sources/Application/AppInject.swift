//
//  AppInject.swift
//  MyApp
//
//  Created by Manh Pham on 09/06/2021.
//

import SwinjectStoryboard

extension SwinjectStoryboard {
    @objc
    class func setup() {
        // Common
        defaultContainer.register(AuthManagerInterface.self) { _ in
            AuthManager()
        }

        defaultContainer.register(ApiConnection.self) { resolve in
            ApiConnection(authManager: resolve.resolve(AuthManagerInterface.self)!)
        }

        defaultContainer.register(RESTfulService.self) { resolve in
            RESTfulServiceComponent(apiConnection: resolve.resolve(ApiConnection.self)!)
        }

        defaultContainer.register(OAuthService.self) { _ in
            OAuthServiceComponent()
        }

        // Interactor
        defaultContainer.register(LoginInteractorInterface.self) { resolve in
            LoginInteractor(restfulService: resolve.resolve(RESTfulService.self)!,
                            oauthService: resolve.resolve(OAuthService.self)!,
                            authManager: resolve.resolve(AuthManagerInterface.self)!)
        }

        defaultContainer.register(MainInteractorInterface.self) { (resolve) in
            MainInteractor(restfulService: resolve.resolve(RESTfulService.self)!,
                           authManager: resolve.resolve(AuthManagerInterface.self)!)
        }
    }
}
