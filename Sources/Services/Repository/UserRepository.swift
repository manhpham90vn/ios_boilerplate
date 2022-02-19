//
//  UserRepository.swift
//  MyApp
//
//  Created by Manh Pham on 11/28/21.
//

import Foundation
import RxSwift
import Resolver

protocol UserRepositoryInterface {
    func getURLAuthen() -> Single<URL>
    func createAccessToken(params: AccessTokenParams) -> Single<Token>
    func getInfo() -> Single<User>
    
    /// token from UserDefault
    var token: String? { get set }
    
    /// user from UserDefault
    var user: User? { get set }
    func isLogin() -> Bool
    func logOut()
}

final class UserRepository {
    @Injected var authManager: AuthManagerInterface
    @Injected var oauthService: OAuthService
    @Injected var restfulService: RESTfulService
}

extension UserRepository: UserRepositoryInterface {
    func getURLAuthen() -> Single<URL> {
        oauthService.getURLAuthen()
    }
    
    func createAccessToken(params: AccessTokenParams) -> Single<Token> {
        restfulService.createAccessToken(params: params)
    }
    
    func getInfo() -> Single<User> {
        restfulService.getInfo()
    }
    
    var token: String? {
        get {
            authManager.token
        }
        set {
            authManager.token = newValue
        }
    }
    
    var user: User? {
        get {
            authManager.user
        }
        set {
            authManager.user = newValue
        }
    }
    
    func isLogin() -> Bool {
        authManager.isLogin
    }
    
    func logOut() {
        authManager.logOut()
    }
}
