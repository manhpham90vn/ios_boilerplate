//
//  UserRepository.swift
//  MyApp
//
//  Created by Manh Pham on 11/28/21.
//

import Foundation
import RxSwift
import MPInjector

protocol UserRepositoryInterface {
    func login(email: String, password: String) -> Single<LoginResponse>
    func userInfo() -> Single<UserResponse>
    func refreshToken(token: String) -> Single<RefreshTokenResponse>
}

final class UserRepository {
    @Inject var api: AppApi
}

extension UserRepository: UserRepositoryInterface {
    func login(email: String, password: String) -> Single<LoginResponse> {
        return api.login(email: email, password: password)
    }

    func userInfo() -> Single<UserResponse> {
        return api.userInfo()
    }

    func refreshToken(token: String) -> Single<RefreshTokenResponse> {
        return api.refreshToken(token: token)
    }
}
