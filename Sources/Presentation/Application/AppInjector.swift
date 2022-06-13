//
//  AppInjector.swift
//  MyApp
//
//  Created by Manh Pham on 09/06/2021.
//

import Resolver

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        // MARK: Service
//        register { AuthManager() as AuthManagerInterface }
//        register { RESTfulServiceComponent() as RESTfulService }
//        register { OAuthServiceComponent() as OAuthService }

        // MARK: Repository
        register { UserRepository() as UserRepositoryInterface }
        register { HomeRepository() as HomeRepositoryInterface }
        
        // MARK: UseCase
//        register { GETURLAuthenUseCase() as GETURLAuthenUseCaseInterFace }
        register { LoginUseCase() as LoginUseCaseInterface }
        register { GETEventUseCase() as GETEventUseCaseInterface }
        register { CleanUserInfoUseCase() as CleanUserInfoUseCaseInterface }
        register { GETLoginStatusUseCase() as GETLoginStatusUseCaseInterface }
        register { GETTokenUseCase() as GETTokenUseCaseInterface }
        
        // MARK: Register All
        MainRouter.registerAllServices()
        LoginRouter.registerAllServices()
        DetailRouter.registerAllServices()
    }
}
