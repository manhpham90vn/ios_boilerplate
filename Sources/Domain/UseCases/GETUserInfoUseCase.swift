//
//  GETUserInfoUseCase.swift
//  MyApp
//
//  Created by Manh Pham on 6/15/22.
//

import Foundation
import RxSwift
import Resolver

protocol GETUserInfoUseCase {
    func getInfo() -> Single<User>
}

final class GETUserInfoUseCaseImp {
    @Injected var repo: UserRepositoryInterface
    @Injected var local: LocalStorageRepository
}

extension GETUserInfoUseCaseImp: GETUserInfoUseCase {
    func getInfo() -> Single<User> {
        repo.userInfo()
            .do(onSuccess: { [weak self] user in
                self?.local.setUserInfo(newValue: user)
            })
    }
}
