//
//  LoginUseCase.swift
//  MyApp
//
//  Created by Manh Pham on 11/28/21.
//

import Foundation
import RxSwift
import RxCocoa
import MPInjector

struct LoginUseCaseParams {
    let email: String
    let password: String
}

final class LoginUseCase: SingleUseCase<LoginUseCaseParams, Bool> {
    @Inject var repo: UserRepositoryInterface
    @Inject var local: LocalStorageRepository
    
    override func buildUseCase(params: LoginUseCaseParams) -> Single<Bool> {
        repo.login(email: params.email, password: params.password)
            .do(onSuccess: { [weak self] data in
                if let token = data.token, let refreshToken = data.refreshToken {
                    self?.local.setAccessToken(newValue: token)
                    self?.local.setRefreshToken(newValue: refreshToken)
                }
            })
            .map { $0.token != nil && $0.refreshToken != nil }
    }
}
