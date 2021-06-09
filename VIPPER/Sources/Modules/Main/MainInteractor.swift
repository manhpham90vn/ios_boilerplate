//
//  MainInteractor.swift
//  VIPPER
//
//  Created by Manh Pham on 3/5/21.
//

import Foundation

protocol MainInteractorInterface {
    func cleanData()
    func getLoginedUser() -> String?
    func getUserReceivedEvents(params: EventParams) -> Observable<[Event]>
}

final class MainInteractor: BaseInteractor, MainInteractorInterface {

    @Inject var restfulService: RESTfulService
    @Inject var authManager: AuthManagerInterface

    deinit {
        LogInfo("\(type(of: self)) Deinit")
    }

    func cleanData() {
        authManager.logOut()
    }
    
    func getLoginedUser() -> String? {
        authManager.user?.login
    }
    
    func getUserReceivedEvents(params: EventParams) -> Observable<[Event]> {
        restfulService.userReceivedEvents(params: params)
    }

}
