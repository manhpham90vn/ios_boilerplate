//
//  GETLoginStatusUseCase.swift
//  MyApp
//
//  Created by Manh Pham on 11/28/21.
//

import Foundation
import Resolver
import RxSwift

protocol GETLoginStatusUseCaseInterface {
    func isLogin() -> Single<Bool>
}

final class GETLoginStatusUseCase {
    @Injected var repo: LocalStorageRepository
}

extension GETLoginStatusUseCase: GETLoginStatusUseCaseInterface {
    func isLogin() -> Single<Bool> {
        return .just(repo.getAccessToken() != nil)
    }
}
