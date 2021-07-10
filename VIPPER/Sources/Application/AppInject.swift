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

        register {
            RESTfulServiceComponent()
        }
        .implements(RESTfulService.self)

        register {
            OAuthServiceComponent()
        }
        .implements(OAuthService.self)
    }
}
