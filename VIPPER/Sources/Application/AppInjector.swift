//
//  AppInjector.swift
//  MyApp
//
//  Created by Manh Pham on 09/06/2021.
//

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        // MARK: Default scrope
        Resolver.defaultScope = .unique
        
        // MARK: Service
        register { AuthManager() as AuthManagerInterface }
        .scope(.cached)

        register { RESTfulServiceComponent() as RESTfulService }
        .scope(.application)

        register { OAuthServiceComponent() as OAuthService }
        .scope(.application)

        // MARK: Register All
        MainRouter.registerAllServices()
        LoginRouter.registerAllServices()
        DetailRouter.registerAllServices()
    }
}
