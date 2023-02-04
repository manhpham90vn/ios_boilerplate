//
//  AppInjector.swift
//  MyApp
//
//  Created by Manh Pham on 09/06/2021.
//

import MPInjector

extension MPInjector: Registering {
    public func registerService() {        
        registerSingleton { UserDefaults.standard as UserDefaults }
        registerSingleton { UserDefaultsStorage() as Storage }
        
        // data remote
        registerSingleton { ConnectivityServiceImpl() as ConnectivityService }
        registerSingleton { AppNetwork() as AppNetworkInterface }
        registerSingleton { AppApiComponent() as AppApi }
        
        // utils
        registerSingleton { LoadingHelperImp() as LoadingHelper }
        registerSingleton { ApiErrorHandlerImp() as ApiErrorHandler }
        registerSingleton { AppHelperImp() as AppHelper }
        registerSingleton { DialogManagerImp() as DialogManager }
        registerSingleton { PermissionManagerImp() as PermissionManager }
        
        // MARK: Repository
        registerSingleton { UserRepository() as UserRepositoryInterface }
        registerSingleton { HomeRepository() as HomeRepositoryInterface }
        registerSingleton { LocalStorage() as LocalStorageRepository }
        
        // MARK: UseCase
        // note: for use case should use factory life time
        registerFactory { LoginUseCase() }
        registerFactory { GETEventUseCase() }
        registerFactory { CleanUserInfoUseCase() }
        registerFactory { GETUserInfoUseCase() }
        registerFactory { RefreshTokenUseCase() }
        
        // MARK: Register for Modules
        registerFactory { MainInteractor() as MainInteractorInterface }
        registerFactory { MainRouter() as MainRouterInterface }
        registerFactory { MainPresenter() as MainPresenterInterface }
        
        registerFactory { LoginInteractor() as LoginInteractorInterface }
        registerFactory { LoginRouter() as LoginRouterInterface }
        registerFactory { LoginPresenter() as LoginPresenterInterface }
        
        registerFactory { DetailInteractor() as DetailInteractorInterface }
        registerFactory { DetailRouter() as DetailRouterInterface }
        registerFactory { DetailPresenter() as DetailPresenterInterface }
    }
}
