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
    func createAccessToken(code: String) -> Single<Token>
    func getURLAuthen() -> Single<URL>
    func getInfo() -> Single<User>
    func saveToken(token: String)
    func saveUserInfo(user: User)
}

class LoginInteractor: LoginInteractorInterface {
    
    let restfulService: RESTfulService
    let oauthService: OAuthService
    
    init(service: RESTfulService, oauthService: OAuthService) {
        self.restfulService = service
        self.oauthService = oauthService
    }
        
    deinit {
        print("\(type(of: self)) Deinit")
    }
    
    func getURLAuthen() -> Single<URL> {
        return oauthService.getURLAuthen()
    }
    
    func createAccessToken(code: String) -> Single<Token> {
        return restfulService.createAccessToken(clientId: Configs.clientID,
                                                clientSecret: Configs.ClientSecrets,
                                                code: code,
                                                redirectUri: nil,
                                                state: nil)
    }
        
    func getInfo() -> Single<User> {
        return restfulService.getInfo()
    }
    
    func saveToken(token: String) {
        AuthManager.shared.token = token
    }
    
    func saveUserInfo(user: User) {
        AuthManager.shared.user = user
    }
    
    
}
