//
//  AppInjector.swift
//  MyApp
//
//  Created by Manh Pham on 09/06/2021.
//

import MPInjector

final class AppInjector {
    static let shared = AppInjector()

    func perform() {
        MPInjector.registerSingleton { UserDefaults.standard as UserDefaults }
        MPInjector.registerSingleton { UserDefaultsStorage() as Storage }

        // data remote
        MPInjector.registerSingleton { ConnectivityServiceImpl() as ConnectivityService }
        MPInjector.registerSingleton { AppApiComponent() as AppApi }
        MPInjector.registerSingleton { AppNetwork() as AppNetworkInterface }

        // utils
        MPInjector.registerSingleton { LoadingHelper() }
        MPInjector.registerSingleton { ApiErrorHandler() }
        MPInjector.registerSingleton { Logger() }

        // MARK: Repository
        MPInjector.registerSingleton { UserRepository() as UserRepositoryInterface }
        MPInjector.registerSingleton { HomeRepository() as HomeRepositoryInterface }
        MPInjector.registerSingleton { LocalStorage() as LocalStorageRepository }

        // MARK: UseCase
        // note: for use case should use factory life time
        MPInjector.registerFactory { LoginUseCase() }
        MPInjector.registerFactory { GETEventUseCase() }
        MPInjector.registerFactory { CleanUserInfoUseCase() }
        MPInjector.registerFactory { GETUserInfoUseCase() }
        MPInjector.registerFactory { RefreshTokenUseCase() }

        // MARK: Register for Modules
        MainRouter.registerAllServices()
        LoginRouter.registerAllServices()
        DetailRouter.registerAllServices()
    }
}
