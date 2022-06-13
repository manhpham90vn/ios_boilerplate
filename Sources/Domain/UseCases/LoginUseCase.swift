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
    func login(email: String, password: String) -> Single<Void>
}

final class LoginUseCase {
    @Injected var repo: UserRepositoryInterface
    @Injected var local: LocalStorageRepository
}

extension LoginUseCase: LoginUseCaseInterface {
    func login(email: String, password: String) -> Single<Void> {
        repo.login(email: email, password: password)
            .do(onSuccess: { [weak self] token in
                self?.local.setAccessToken(newValue: token.token)
                self?.local.setRefreshToken(newValue: token.refreshToken)
            })
            .map { _ in }
    }
}
