//
//  HomeRepository.swift
//  MyApp
//
//  Created by Manh Pham on 11/28/21.
//

import Foundation
import RxSwift
import RxCocoa
import MPInjector

protocol HomeRepositoryInterface {
    func pagging(page: Int, sort: PagingSortType) -> Single<[PagingUserResponse]>
}

final class HomeRepository {
    @Inject var api: AppApi
}

extension HomeRepository: HomeRepositoryInterface {
    func pagging(page: Int, sort: PagingSortType) -> Single<[PagingUserResponse]> {
        api.paging(page: page, sort: sort)
    }
}
