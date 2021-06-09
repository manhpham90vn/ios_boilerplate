//
//  AppInject.swift
//  MyApp
//
//  Created by Manh Pham on 09/06/2021.
//

extension DependencyContainer {
    static var authManager = module {
        single { AuthManager() as AuthManagerInterface }
    }

    static var restfulService = module {
        single { RESTfulServiceComponent() as RESTfulService }
    }

    static var oauthService = module {
        single { OAuthServiceComponent() as OAuthService }
    }
}
