//
//  CleanUserInfoUseCase.swift
//  MyApp
//
//  Created by Manh Pham on 11/28/21.
//

import Foundation
import Resolver

protocol CleanUserInfoUseCaseInterface {
    func clean()
}

final class CleanUserInfoUseCase {
    @Injected var repo: UserRepositoryInterface
}

extension CleanUserInfoUseCase: CleanUserInfoUseCaseInterface {
    func clean() {
        repo.logOut()
    }
}
