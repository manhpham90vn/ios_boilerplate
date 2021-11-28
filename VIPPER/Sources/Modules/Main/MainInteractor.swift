//
//  MainInteractor.swift
//  VIPPER
//
//  Created by Manh Pham on 3/5/21.
//

import Foundation

protocol MainInteractorInterface {
    func cleanData()
    func getUserReceivedEvents(page: Int) -> Observable<[Event]>
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

    func getUserReceivedEvents(page: Int) -> Observable<[Event]> {
        getEventUseCaseInterface.userReceivedEvents(page: page)
    }

}
