//
//  GETEventUseCase.swift
//  MyApp
//
//  Created by Manh Pham on 11/28/21.
//

import Foundation
import RxSwift
import RxCocoa
import Resolver

protocol GETEventUseCaseInterface {
    func paging(page: Int) -> Single<[Paging]>
}

final class GETEventUseCase {
    @Injected var repo: HomeRepositoryInterface
}

extension GETEventUseCase: GETEventUseCaseInterface {
    func paging(page: Int) -> Single<[Paging]> {
        repo.pagging(page: page)
    }
}
