//
//  HomeRepository.swift
//  MyApp
//
//  Created by Manh Pham on 11/28/21.
//

import Foundation

protocol HomeRepositoryInterface {
    func userReceivedEvents(params: EventParams) -> Observable<[Event]>
}

final class HomeRepository {
    @Injected var restfulService: RESTfulService
}

extension HomeRepository: HomeRepositoryInterface {
    func userReceivedEvents(params: EventParams) -> Observable<[Event]> {
        restfulService.userReceivedEvents(params: params)
    }
}
