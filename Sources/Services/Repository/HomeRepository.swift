//
//  HomeRepository.swift
//  MyApp
//
//  Created by Manh Pham on 11/28/21.
//

import Foundation
import RxSwift
import RxCocoa
import Resolver

protocol HomeRepositoryInterface {
    func userReceivedEvents(params: EventParams) -> Single<[Event]>
}

final class HomeRepository {
    @Injected var restfulService: RESTfulService
}

extension HomeRepository: HomeRepositoryInterface {
    func userReceivedEvents(params: EventParams) -> Single<[Event]> {
        restfulService.userReceivedEvents(params: params)
    }
}
