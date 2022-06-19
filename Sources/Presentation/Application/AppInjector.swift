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
        register { AppApiComponent() as AppApi }

        // MARK: Repository
        register { UserRepository() as UserRepositoryInterface }
        register { HomeRepository() as HomeRepositoryInterface }
        register { LocalStorage() as LocalStorageRepository }
        
        // MARK: UseCase
        register { LoginUseCase() as LoginUseCaseInterface }
        register { GETEventUseCase() as GETEventUseCaseInterface }
        register { CleanUserInfoUseCase() as CleanUserInfoUseCaseInterface }
        register { GETLoginStatusUseCase() as GETLoginStatusUseCaseInterface }
        register { GETTokenUseCase() as GETTokenUseCaseInterface }
        register { GETUserInfoUseCaseImp() as GETUserInfoUseCase }
        register { RefreshTokenImp() as RefreshTokenUseCase }
        
        // MARK: Register All
        MainRouter.registerAllServices()
        LoginRouter.registerAllServices()
        DetailRouter.registerAllServices()
    }
}
