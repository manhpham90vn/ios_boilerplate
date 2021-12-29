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

enum GETEventUseCaseError: Error {
    case userNotFound
    
    var message: String {
        switch self {
        case .userNotFound:
            return "Can not get user name"
        }
    }
}

final class GETEventUseCase {
    @Injected var repo: HomeRepositoryInterface
    @Injected var userRepo: UserRepositoryInterface
}

extension GETEventUseCase: GETEventUseCaseInterface {
    func userReceivedEvents(page: Int) -> Observable<[Event]> {
        if let userName = userRepo.user?.login {
            let params = EventParams(username: userName, page: page)
            return repo.userReceivedEvents(params: params)
        }
        return .error(GETEventUseCaseError.userNotFound)
    }
}
