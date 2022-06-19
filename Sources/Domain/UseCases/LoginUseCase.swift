//
//  LoginUseCase.swift
//  MyApp
//
//  Created by Manh Pham on 11/28/21.
//

import Foundation
import RxSwift
import RxCocoa
import Resolver

protocol LoginUseCaseInterface {
    func login(email: String, password: String) -> Single<Token>
}

final class LoginUseCase {
    @Injected var repo: UserRepositoryInterface
    @Injected var local: LocalStorageRepository
}

extension LoginUseCase: LoginUseCaseInterface {
    func login(email: String, password: String) -> Single<Token> {
        repo.login(email: email, password: password)
            .do(onSuccess: { [weak self] data in
                if let token = data.token, let refreshToken = data.refreshToken {
                    self?.local.setAccessToken(newValue: token)
                    self?.local.setRefreshToken(newValue: refreshToken)
                    self?.local.setLoginState(newValue: .logined)
                }
            })
    }
}
