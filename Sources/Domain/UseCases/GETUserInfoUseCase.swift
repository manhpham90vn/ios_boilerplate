//
//  GETUserInfoUseCase.swift
//  MyApp
//
//  Created by Manh Pham on 6/15/22.
//

import Foundation
import RxSwift
import Resolver

final class GETUserInfoUseCase: SingleUseCase<Void, UserResponse> {
    @Injected var repo: UserRepositoryInterface
    @Injected var local: LocalStorageRepository
    
    override func buildUseCase(params: Void) -> Single<UserResponse> {
        return repo.userInfo()
            .do(onSuccess: { [weak self] user in
                self?.local.setUserInfo(newValue: user)
            })
    }
}
