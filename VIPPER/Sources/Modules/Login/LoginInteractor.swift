//
//  LoginInteractor.swift
//  VIPPER
//
//  Created by Manh Pham on 3/4/21.
//

import UIKit
import RxSwift
import RxCocoa

protocol LoginInteractorInterface {
    func createAccessToken(params: AccessTokenParams) -> Observable<Token>
    func getURLAuthen() -> Observable<URL>
    func getInfo() -> Observable<User>
    func saveToken(token: String)
    func saveUserInfo(user: User)
}

final class LoginInteractor: BaseInteractor, LoginInteractorInterface {
    
    let restfulService: RESTfulService
    let oauthService: OAuthService
    
    init(service: RESTfulService, oauthService: OAuthService) {
        self.restfulService = service
        self.oauthService = oauthService
    }

    deinit {
        LogInfo("\(type(of: self)) Deinit")
        LeakDetector.instance.expectDeallocate(object: restfulService as AnyObject)
        LeakDetector.instance.expectDeallocate(object: oauthService as AnyObject)
    }
            
    func getURLAuthen() -> Observable<URL> {
        return oauthService.getURLAuthen()
    }
    
    func createAccessToken(params: AccessTokenParams) -> Observable<Token> {
        return restfulService.createAccessToken(params: params)
    }
        
    func getInfo() -> Observable<User> {
        return restfulService.getInfo()
    }
    
    func saveToken(token: String) {
        AuthManager.shared.token = token
    }
    
    func saveUserInfo(user: User) {
        AuthManager.shared.user = user
    }

}
