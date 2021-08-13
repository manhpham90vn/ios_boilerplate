//
//  AppInject.swift
//  MyApp
//
//  Created by Manh Pham on 09/06/2021.
//

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        register {
            AuthManager()
        }
        .implements(AuthManagerInterface.self)
        .scope(.application)

        register {
            RESTfulServiceComponent()
        }
        .implements(RESTfulService.self)
        .scope(.application)

        register {
            OAuthServiceComponent()
        }
        .implements(OAuthService.self)
        .scope(.graph)
    }
}
