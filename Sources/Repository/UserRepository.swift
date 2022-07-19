//
//  UserRepository.swift
//  MyApp
//
//  Created by Manh Pham on 11/28/21.
//

import Foundation
import RxSwift
import Resolver

protocol UserRepositoryInterface {
    func login(email: String, password: String) -> Single<Token>
    func userInfo() -> Single<User>
    func refreshToken(token: String) -> Single<RefreshToken>
}

final class UserRepository {
    @Injected var api: AppApi
}

extension UserRepository: UserRepositoryInterface {
    func login(email: String, password: String) -> Single<Token> {
        return api.login(email: email, password: password)
    }

    func userInfo() -> Single<User> {
        return api.userInfo()
    }

    func refreshToken(token: String) -> Single<RefreshToken> {
        return api.refreshToken(token: token)
    }
}
