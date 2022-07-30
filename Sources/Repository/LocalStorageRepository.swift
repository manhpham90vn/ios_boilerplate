//
//  LocalStorageRepository.swift
//  MyApp
//
//  Created by Manh Pham on 6/13/22.
//

import Foundation
import RxSwift
import Resolver

protocol LocalStorageRepository {
    func getAccessToken() -> String?
    func setAccessToken(newValue: String)
    func clearAccessToken()
    
    func getRefreshToken() -> String?
    func setRefreshToken(newValue: String)
    func clearRefreshToken()
    
    func getLoginState() -> LoginState
    
    func getUserInfo() -> UserResponse?
    func setUserInfo(newValue: UserResponse)
    func clearUserInfo()
}

final class LocalStorage: LocalStorageRepository {
    
    @Injected var storage: Storage
    
    func getAccessToken() -> String? {
        storage.getString(key: StorageConstants.token)
    }
    
    func setAccessToken(newValue: String) {
        storage.setString(key: StorageConstants.token, value: newValue)
    }
    
    func clearAccessToken() {
        storage.clear(key: StorageConstants.token)
    }
    
    func getRefreshToken() -> String? {
        storage.getString(key: StorageConstants.refreshToken)
    }
    
    func setRefreshToken(newValue: String) {
        storage.setString(key: StorageConstants.refreshToken, value: newValue)
    }
    
    func clearRefreshToken() {
        storage.clear(key: StorageConstants.refreshToken)
    }
    
    func getLoginState() -> LoginState {
        (storage.getString(key: StorageConstants.token) != nil &&
         storage.getString(key: StorageConstants.refreshToken) != nil)
        ? LoginState.logined : LoginState.notLogin
    }

    func getUserInfo() -> UserResponse? {
        try? storage.getObject(key: StorageConstants.user)
    }
    
    func setUserInfo(newValue: UserResponse) {
        try? storage.setObject(key: StorageConstants.user, value: newValue)
    }
    
    func clearUserInfo() {
        storage.clear(key: StorageConstants.user)
    }
}
