//
//  AppApi.swift
//  VIPER
//
//  Created by Manh Pham on 2/8/21.
//

import Foundation
import RxSwift
import RxCocoa

protocol AppApi {
    func login(email: String, password: String) -> Single<Token>
    func userInfo() -> Single<User>
    func paging(page: Int) -> Single<[Paging]>
    func refreshToken(token: String) -> Single<RefreshToken>
}

final class AppApiComponent: AppApi {
    func login(email: String, password: String) -> Single<Token> {
        return AppNetwork.default.request(route: AppRoute.login(username: email, password: password), type: LoginResponse.self)
            .map { $0.asEntity() }
    }
    
    func userInfo() -> Single<User> {
        return AppNetwork.default.request(route: AppRoute.getUserInfo, type: UserResponse.self)
            .map { $0.asEntity() }
    }
    
    func paging(page: Int) -> Single<[Paging]> {
        return AppNetwork.default.request(route: AppRoute.getList(page: page), type: PagingResponse.self)
            .map { $0.asEntity() }
    }
    
    func refreshToken(token: String) -> Single<RefreshToken> {
        return AppNetwork.default.request(route: AppRoute.refreshToken(token: token), type: RefreshTokenResponse.self)
            .map { $0.asEntity() }
    }
}
