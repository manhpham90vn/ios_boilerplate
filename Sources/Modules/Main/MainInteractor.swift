//
//  MainInteractor.swift
//  VIPPER
//
//  Created by Manh Pham on 3/5/21.
//

import Foundation
import RxSwift
import Resolver

protocol MainInteractorInterface {
    func cleanData()
    func getUserReceivedEvents(page: Int) -> Single<[Event]>
}

final class MainInteractor: MainInteractorInterface {

    @Injected var getEventUseCaseInterface: GETEventUseCaseInterface
    @Injected var cleanUserInfoUseCaseInterface: CleanUserInfoUseCaseInterface

    deinit {
        if Configs.shared.loggingDeinitEnabled {
            LogInfo("\(Swift.type(of: self)) Deinit")
        }
    }

    func cleanData() {
        cleanUserInfoUseCaseInterface.clean()
    }

    func getUserReceivedEvents(page: Int) -> Single<[Event]> {
        getEventUseCaseInterface.userReceivedEvents(page: page)
    }

}
