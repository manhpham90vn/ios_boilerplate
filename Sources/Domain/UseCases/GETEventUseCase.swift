//
//  GETEventUseCase.swift
//  MyApp
//
//  Created by Manh Pham on 11/28/21.
//

import Foundation
import RxSwift
import RxCocoa
import MPInjector

enum PagingSortType: String {
    case ascending
    case descending
}

enum PagingType {
    case refreshOrFirstLoad
    case loadMore
}

struct GETEventUseCaseParams {
    let page: Int
    let sort: PagingSortType
    let type: PagingType
}

/// @mockable
class GETEventUseCase: SingleUseCase<GETEventUseCaseParams, ([PagingUserResponse], PagingType)> {
    
    @Inject var repo: HomeRepositoryInterface
    
    override func buildUseCase(params: GETEventUseCaseParams) -> Single<([PagingUserResponse], PagingType)> {
        return repo.pagging(page: params.page, sort: params.sort).map { ($0, params.type) }
    }
}
