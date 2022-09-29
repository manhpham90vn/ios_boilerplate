//
//  CleanUserInfoUseCase.swift
//  MyApp
//
//  Created by Manh Pham on 11/28/21.
//

import Foundation
import RxSwift
import MPInjector

final class CleanUserInfoUseCase: UseCase {
    
    var cacheParams: Void?
    
    @Inject var repo: LocalStorageRepository
}

extension CleanUserInfoUseCase {
    func buildUseCase(params: Void) {
        repo.clearAccessToken()
        repo.clearRefreshToken()
        repo.clearUserInfo()
        RefreshTokenInterceptor.lastFailedDate = nil
    }
}
