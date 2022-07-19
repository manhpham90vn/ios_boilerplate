//
//  LocalStorageRepository.swift
//  MyApp
//
//  Created by Manh Pham on 6/13/22.
//

import Foundation
import RxSwift
import SwiftyUserDefaults

protocol LocalStorageRepository {
    func getAccessToken() -> String?
    func setAccessToken(newValue: String?)
    func clearAccessToken()
    
    func getRefreshToken() -> String?
    func setRefreshToken(newValue: String?)
    func clearRefreshToken()
    
    func getLoginState() -> LoginState?
    func setLoginState(newValue: LoginState?)
    func clearLoginState()
    
    func getUserInfo() -> User?
    func setUserInfo(newValue: User?)
    func clearUserInfo()
}

final class LocalStorage: LocalStorageRepository {
    @SwiftyUserDefault(keyPath: \.token, options: .cached)
    private var token: String?

    @SwiftyUserDefault(keyPath: \.refreshToken, options: .cached)
    private var refreshToken: String?

    @SwiftyUserDefault(keyPath: \.loginState, options: .cached)
    private var state: LoginState?
    
    @SwiftyUserDefault(keyPath: \.user, options: .cached)
    private var user: User?
    
    func getAccessToken() -> String? {
        token
    }
    
    func setAccessToken(newValue: String?) {
        token = newValue
    }
    
    func clearAccessToken() {
        token = nil
    }
    
    func getRefreshToken() -> String? {
        refreshToken
    }
    
    func setRefreshToken(newValue: String?) {
        refreshToken = newValue
    }
    
    func clearRefreshToken() {
        refreshToken = nil
    }
    
    func getLoginState() -> LoginState? {
        state
    }
    
    func setLoginState(newValue: LoginState?) {
        state = newValue
    }
    
    func clearLoginState() {
        state = nil
    }
    
    func getUserInfo() -> User? {
        user
    }
    
    func setUserInfo(newValue: User?) {
        user = newValue
    }
    
    func clearUserInfo() {
        user = nil
    }
}
