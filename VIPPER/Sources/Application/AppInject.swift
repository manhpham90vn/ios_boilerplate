//
//  AppInject.swift
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

        // MARK: Login screen
        register { LoginInteractor() as LoginInteractorInterface }
        register { LoginRouter() as LoginRouterInterface }
        register { LoginPresenter() as LoginPresenterInterface }
        
        register { DetailInteractor() as DetailInteractorInterface }
        register { DetailRouter() as DetailRouterInterface }
        register { DetailPresenter() as DetailPresenterInterface }
        
        register { MainInteractor() as MainInteractorInterface }
        register { MainRouter() as MainRouterInterface }
        register { MainPresenter() as MainPresenterInterface }
    }
}
