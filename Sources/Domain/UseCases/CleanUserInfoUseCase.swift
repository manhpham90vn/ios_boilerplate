//
//  CleanUserInfoUseCase.swift
//  MyApp
//
//  Created by Manh Pham on 11/28/21.
//

import Foundation
import Resolver
import RxSwift

final class CleanUserInfoUseCase: UseCase {
    @Injected var repo: LocalStorageRepository
}

extension CleanUserInfoUseCase {
    func buildUseCase(params: Void) {
        repo.clearAccessToken()
        repo.clearRefreshToken()
        repo.clearUserInfo()
    }
}
