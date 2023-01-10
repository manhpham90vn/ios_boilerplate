//
//  AppApi.swift
//  VIPER
//
//  Created by Manh Pham on 2/8/21.
//

import Foundation
import RxSwift
import RxCocoa
import MPInjector
import Alamofire

protocol AppApi {
    func login(email: String, password: String) -> Single<LoginResponse>
    func userInfo() -> Single<UserResponse>
    func paging(page: Int, sort: PagingSortType) -> Single<[PagingUserResponse]>
    func refreshToken(token: String) -> Single<RefreshTokenResponse>
}

final class AppApiComponent: AppApi {
    
    @Inject var appNetwork: AppNetworkInterface
    
    init() {
        let config = URLSessionConfiguration.af.default
        config.timeoutIntervalForRequest = 30
        config.timeoutIntervalForResource = 30
        config.allowsCellularAccess = true
        
        // Adapter
        let xTypeAdapter = XTypeAdapter()
        let authenAdapter = AuthenAdapter()
        
        // Interceptors
        let refreshTokenInterceptor = RefreshTokenInterceptor()
        let retryPolicy = RetryPolicy(retryLimit: 3, retryableHTTPMethods: [.get], retryableHTTPStatusCodes: [])
        
        // EventMonitor
        var eventMonitors: [EventMonitor] = []
        #if DEBUG
        let logger = AppMonitor()
        eventMonitors.append(logger)
        #endif
        appNetwork.setup(config: config, adapters: [xTypeAdapter, authenAdapter], interceptors: [refreshTokenInterceptor, retryPolicy], eventMonitors: eventMonitors)
    }
    
    func login(email: String, password: String) -> Single<LoginResponse> {
        let route = AppRoute.login(username: email, password: password)
        return appNetwork.request(route: route,
                                  type: LoginResponse.self)
    }
    
    func userInfo() -> Single<UserResponse> {
        let route = AppRoute.getUserInfo
        return appNetwork.requestRefreshable(route: route,
                                             type: UserResponse.self)
    }
    
    func paging(page: Int, sort: PagingSortType) -> Single<[PagingUserResponse]> {
        let route = AppRoute.getList(page: page, sort: sort)
        return appNetwork.requestRefreshable(route: route,
                                             type: PagingResponse.self)
            .map { $0.array ?? [] }
    }
    
    func refreshToken(token: String) -> Single<RefreshTokenResponse> {
        return appNetwork.request(route: AppRoute.refreshToken(token: token),
                                  type: RefreshTokenResponse.self)
    }
}
