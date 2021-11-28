//
//  GETLoginStatusUseCase.swift
//  MyApp
//
//  Created by Manh Pham on 11/28/21.
//

import Foundation

protocol GETLoginStatusUseCaseInterface {
    func isLogin() -> Bool
}

final class GETLoginStatusUseCase {
    @Injected var repo: UserRepositoryInterface
}

extension GETLoginStatusUseCase: GETLoginStatusUseCaseInterface {
    func isLogin() -> Bool {
        repo.isLogin()
    }
}
