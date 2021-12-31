//
//  GETEventUseCase.swift
//  MyApp
//
//  Created by Manh Pham on 11/28/21.
//

import Foundation

protocol GETEventUseCaseInterface {
    func userReceivedEvents(page: Int) -> Observable<[Event]>
}

final class GETEventUseCase {
    @Injected var repo: HomeRepositoryInterface
    @Injected var userRepo: UserRepositoryInterface
}

extension GETEventUseCase: GETEventUseCaseInterface {
    func userReceivedEvents(page: Int) -> Observable<[Event]> {
        let userName = userRepo.user?.login ?? "manhpham90vn"
        let params = EventParams(username: userName, page: page)
        return repo.userReceivedEvents(params: params)
    }
}
