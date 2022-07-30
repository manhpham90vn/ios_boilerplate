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

final class GETEventUseCase: SingleUseCase<GETEventUseCaseParams, ([PagingUserResponse], PagingType)> {
    
    @Injected var repo: HomeRepositoryInterface
    
    override func buildUseCase(params: GETEventUseCaseParams) -> Single<([PagingUserResponse], PagingType)> {
        return repo.pagging(page: params.page, sort: params.sort).map { ($0, params.type) }
    }
}
