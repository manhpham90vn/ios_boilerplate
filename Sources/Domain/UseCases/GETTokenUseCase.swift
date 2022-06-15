//
//  GETTokenUseCase.swift
//  MyApp
//
//  Created by Manh Pham on 11/28/21.
//

import Foundation
import RxSwift
import RxCocoa
import Resolver

protocol GETTokenUseCaseInterface {
    func getToken() -> String?
}

final class GETTokenUseCase {
    @Injected var repo: LocalStorageRepository
}

extension GETTokenUseCase: GETTokenUseCaseInterface {
    func getToken() -> String? {
        repo.getAccessToken()
    }
}
