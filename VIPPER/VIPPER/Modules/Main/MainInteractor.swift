//
//  MainInteractor.swift
//  VIPPER
//
//  Created by Manh Pham on 3/5/21.
//

import Foundation
import RxSwift

protocol MainInteractorInterface {
    func cleanData()
    func getLoginedUser() -> String?
    func getUserReceivedEvents(params: EventParams) -> Observable<[Event]>
}

class MainInteractor: BaseInteractor, MainInteractorInterface {

    let restfulService: RESTfulService
    
    internal init(restfulService: RESTfulService) {
        self.restfulService = restfulService
    }

    deinit {
        print("\(type(of: self)) Deinit")
        LeakDetector.instance.expectDeallocate(object: restfulService as AnyObject)
    }

    func cleanData() {
        AuthManager.shared.logOut()
    }
    
    func getLoginedUser() -> String? {
        return AuthManager.shared.user?.login
    }
    
    func getUserReceivedEvents(params: EventParams) -> Observable<[Event]> {
        return restfulService.userReceivedEvents(params: params)
    }

}
