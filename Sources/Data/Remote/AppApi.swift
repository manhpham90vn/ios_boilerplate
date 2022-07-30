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
        return appNetwork.request(route: AppRoute.login(username: email,
                                                        password: password),
                                          type: LoginResponse.self)
    }
    
    func userInfo() -> Single<UserResponse> {
        return appNetwork.requestRefreshable(route: AppRoute.getUserInfo,
                                             type: UserResponse.self)
    }
    
    func paging(page: Int, sort: PagingSortType) -> Single<[PagingUserResponse]> {
        return appNetwork.requestRefreshable(route: AppRoute.getList(page: page,
                                                                     sort: sort),
                                          type: PagingResponse.self)
            .map { $0.array ?? [] }
    }
    
    func refreshToken(token: String) -> Single<RefreshTokenResponse> {
        return appNetwork.request(route: AppRoute.refreshToken(token: token),
                                  type: RefreshTokenResponse.self)
    }
}
