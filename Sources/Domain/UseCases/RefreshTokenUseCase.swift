//
//  RefreshTokenUseCase.swift
//  MyApp
//
//  Created by Manh Pham on 6/15/22.
//

import Foundation
import RxSwift
import Resolver

protocol RefreshTokenUseCase {
    func getNewToken() -> Single<RefreshToken>
}

final class RefreshTokenImp {
    @Injected var userRepo: UserRepositoryInterface
    @Injected var local: LocalStorageRepository
}

extension RefreshTokenImp: RefreshTokenUseCase {
    func getNewToken() -> Single<RefreshToken> {
        guard let token = local.getRefreshToken() else { return .never() }
        return userRepo.refreshToken(token: token)
            .do(onSuccess: { [weak self] token in
                self?.local.setAccessToken(newValue: token.token)
            })
    }
}
