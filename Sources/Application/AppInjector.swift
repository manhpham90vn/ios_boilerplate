//
//  AppInjector.swift
//  MyApp
//
//  Created by Manh Pham on 09/06/2021.
//

import Resolver

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {

        // data local
        register { UserDefaults.standard as UserDefaults }.scope(.application)
        register { UserDefaultsStorage() as Storage }.scope(.application)
        
        // data remote
        register { ConnectivityServiceImpl() as ConnectivityService }.scope(.application)
        register { AppApiComponent() as AppApi }.scope(.application)
        register { AppNetwork() as AppNetworkInterface }.scope(.application)

        // utils
        register { LoadingHelper() }.scope(.application)
        register { ApiErrorHandler() }.scope(.application)
        register { Logger() }.scope(.application)
        
        // MARK: Repository
        register { UserRepository() as UserRepositoryInterface }
        register { HomeRepository() as HomeRepositoryInterface }
        register { LocalStorage() as LocalStorageRepository }
        
        // MARK: UseCase
        register { LoginUseCase() }
        register { GETEventUseCase() }
        register { CleanUserInfoUseCase() }
        register { GETUserInfoUseCase() }
        register { RefreshTokenUseCase() }
        
        // MARK: Register All
        MainRouter.registerAllServices()
        LoginRouter.registerAllServices()
        DetailRouter.registerAllServices()
    }
}
