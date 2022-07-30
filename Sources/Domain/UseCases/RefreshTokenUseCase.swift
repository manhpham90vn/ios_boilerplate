//
//  RefreshTokenUseCase.swift
//  MyApp
//
//  Created by Manh Pham on 6/15/22.
//

import Foundation
import RxSwift
import Resolver

final class RefreshTokenUseCase: SingleUseCase<Void, RefreshTokenResponse> {
    @LazyInjected var userRepo: UserRepositoryInterface
    @Injected var local: LocalStorageRepository
    
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
