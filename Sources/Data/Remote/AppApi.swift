//
//  AppApi.swift
//  VIPER
//
//  Created by Manh Pham on 2/8/21.
//

import Foundation
import RxSwift
import RxCocoa
import Resolver

protocol AppApi {
    func login(email: String, password: String) -> Single<LoginResponse>
    func userInfo() -> Single<UserResponse>
    func paging(page: Int, sort: PagingSortType) -> Single<[PagingUserResponse]>
    func refreshToken(token: String) -> Single<RefreshTokenResponse>
}

final class AppApiComponent: AppApi {
    
    @Injected var appNetwork: AppNetworkInterface
    
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
