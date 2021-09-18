//
//  LoginInteractor.swift
//  VIPPER
//
//  Created by Manh Pham on 3/4/21.
//

import UIKit

protocol LoginInteractorInterface {
    func createAccessToken(params: AccessTokenParams) -> Observable<Token>
    func getURLAuthen() -> Observable<URL>
    func getInfo() -> Observable<User>
    func saveToken(token: String)
    func saveUserInfo(user: User)
}

final class LoginInteractor: LoginInteractorInterface {

    @Injected var restfulService: RESTfulService
    @Injected var oauthService: OAuthService
    @Injected var authManager: AuthManagerInterface

    deinit {
        if Configs.shared.loggingDeinitEnabled {
            LogInfo("\(Swift.type(of: self)) Deinit")
        }
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
        authManager.token = token
    }
    
    func saveUserInfo(user: User) {
        authManager.user = user
    }

}
