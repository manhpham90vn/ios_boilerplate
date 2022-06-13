//
//  AppApi.swift
//  VIPER
//
//  Created by Manh Pham on 2/8/21.
//

import Foundation
import RxSwift
import RxCocoa
import Moya

protocol AppApi {
    func login(email: String, password: String) -> Single<Token>
    func userInfo() -> Single<User>
    func paging(page: Int) -> Single<[Paging]>
    func refreshToken(token: String) -> Single<RefreshToken>
}

final class AppApiComponent: AppApi {
    func login(email: String, password: String) -> Single<Token> {
        return ApiConnection.shared.request(target: MultiTarget(AppRouter.login(email: email,
                                                                                password: password)),
                                            type: LoginResponse.self)
            .map { $0.asEntity() }
    }
    
    func userInfo() -> Single<User> {
        return ApiConnection.shared.request(target: MultiTarget(AppRouter.userInfo), type: UserResponse.self)
            .map { $0.asEntity() }
    }
    
    func paging(page: Int) -> Single<[Paging]> {
        return ApiConnection.shared.request(target: MultiTarget(AppRouter.paging(page: page)), type: PagingResponse.self)
            .map { $0.asEntity() }
    }
    
    func refreshToken(token: String) -> Single<RefreshToken> {
        return ApiConnection.shared
            .request(target: MultiTarget(AppRouter.refreshToken(token: token)), type: RefreshTokenResponse.self)
            .map { $0.asEntity() }
    }
}
