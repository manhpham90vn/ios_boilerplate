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

/// @mockable
class LoginUseCase: CompletableUseCase<LoginUseCaseParams> {
    @Inject var repo: UserRepositoryInterface
    @Inject var local: LocalStorageRepository
    
    override func buildUseCase(params: LoginUseCaseParams) -> Completable {
        repo.login(email: params.email, password: params.password)
            .do(onSuccess: { [weak self] data in
                if let token = data.token, let refreshToken = data.refreshToken {
                    self?.local.setAccessToken(newValue: token)
                    self?.local.setRefreshToken(newValue: refreshToken)
                }
            })
            .asCompletable()
    }
}
