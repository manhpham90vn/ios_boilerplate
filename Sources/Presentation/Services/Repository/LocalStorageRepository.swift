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
    func setAccessToken(newValue: String)
    func clearAccessToken()
    
    func getRefreshToken() -> String?
    func setRefreshToken(newValue: String)
    func clearRefreshToken()
    
    func getLoginState() -> LoginState?
    func setLoginState(newValue: LoginState)
    func clearLoginState()
    
    func getUserInfo() -> User?
    func setUserInfo(newValue: User)
    func clearUserInfo()
}

extension Token: DefaultsSerializable {}
extension RefreshToken: DefaultsSerializable {}
extension LoginState: DefaultsSerializable {
    static var _defaults: DefaultsCodableBridge<LoginState> {
        return DefaultsCodableBridge<LoginState>()
    }
    
    static var _defaultsArray: DefaultsCodableBridge<[LoginState]> {
        return  DefaultsCodableBridge<[LoginState]>()
    }
}
extension User: DefaultsSerializable {}

extension DefaultsKeys {
    
    var token: DefaultsKey<String?> {
        .init("token", defaultValue: nil)
    }
    
    var refreshToken: DefaultsKey<String?> {
        .init("refreshToken", defaultValue: nil)
    }
    
    var loginState: DefaultsKey<LoginState?> {
        .init("loginState", defaultValue: nil)
    }

    var user: DefaultsKey<User?> {
        .init("user", defaultValue: nil)
    }
}

final class LocalStorage: LocalStorageRepository {
    @SwiftyUserDefault(keyPath: \.token, options: .cached)
    var token: String?

    @SwiftyUserDefault(keyPath: \.refreshToken, options: .cached)
    var refreshToken: String?

    @SwiftyUserDefault(keyPath: \.loginState, options: .cached)
    var state: LoginState?
    
    @SwiftyUserDefault(keyPath: \.user, options: .cached)
    var user: User?
    
    func getAccessToken() -> String? {
        token
    }
    
    func setAccessToken(newValue: String) {
        token = newValue
    }
    
    func clearAccessToken() {
        token = nil
    }
    
    func getRefreshToken() -> String? {
        refreshToken
    }
    
    func setRefreshToken(newValue: String) {
        refreshToken = newValue
    }
    
    func clearRefreshToken() {
        refreshToken = nil
    }
    
    func getLoginState() -> LoginState? {
        state
    }
    
    func setLoginState(newValue: LoginState) {
        state = newValue
    }
    
    func clearLoginState() {
        state = nil
    }
    
    func getUserInfo() -> User? {
        user
    }
    
    func setUserInfo(newValue: User) {
        user = newValue
    }
    
    func clearUserInfo() {
        user = nil
    }
}
