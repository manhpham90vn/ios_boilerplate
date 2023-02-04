//
//  RefreshTokenUseCase.swift
//  MyApp
//
//  Created by Manh Pham on 6/15/22.
//

import Foundation
import RxSwift
import MPInjector

/// @mockable
class RefreshTokenUseCase: SingleUseCase<Void, RefreshTokenResponse> {
    @LazyInject var userRepo: UserRepositoryInterface // prevent Circular Dependency use @LazyInject
    @Inject var local: LocalStorageRepository
    
    override func buildUseCase(params: Void) -> Single<RefreshTokenResponse> {
        let token = local.getRefreshToken() ?? ""
        return userRepo.refreshToken(token: token)
            .do(onSuccess: { [weak self] token in
                if let token = token.token {
                    self?.local.setAccessToken(newValue: token)
                }
            })
    }
}
