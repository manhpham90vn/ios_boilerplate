//
//  MainInteractor.swift
//  VIPPER
//
//  Created by Manh Pham on 3/5/21.
//

import Foundation
import RxSwift
import SwinjectStoryboard

protocol MainInteractorInterface {
    func cleanData()
    func getLoginedUser() -> String?
    func getUserReceivedEvents(params: EventParams) -> Observable<[Event]>
}

final class MainInteractor: BaseInteractor, MainInteractorInterface {

    internal init(restfulService: RESTfulService, authManager: AuthManagerInterface) {
        self.restfulService = restfulService
        self.authManager = authManager
    }

    let restfulService: RESTfulService
    let authManager: AuthManagerInterface

    deinit {
        LogInfo("\(type(of: self)) Deinit")
        LeakDetector.instance.expectDeallocate(object: restfulService as AnyObject)
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
