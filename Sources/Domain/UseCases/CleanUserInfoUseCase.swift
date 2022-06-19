//
//  CleanUserInfoUseCase.swift
//  MyApp
//
//  Created by Manh Pham on 11/28/21.
//

import Foundation
import Resolver
import RxSwift

protocol CleanUserInfoUseCaseInterface {
    func clean()
}

final class CleanUserInfoUseCase {
    @Injected var repo: LocalStorageRepository
}

extension CleanUserInfoUseCase: CleanUserInfoUseCaseInterface {
    func clean() {
        repo.clearAccessToken()
        repo.clearRefreshToken()
        repo.clearUserInfo()
        repo.clearLoginState()
    }
}
