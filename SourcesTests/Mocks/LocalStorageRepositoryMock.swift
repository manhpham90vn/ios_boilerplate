//
//  LocalStorageRepositoryMock.swift
//  MyProductTests
//
//  Created by manh on 02/02/2023.
//

import Foundation
import RxSwift

@testable import MyProduct

class LocalStorageRepositoryMock: LocalStorageRepository {
    func getAccessToken() -> String? {
        return nil
    }
    
    func setAccessToken(newValue: String) {}
    
    func clearAccessToken() {}
    
    func getRefreshToken() -> String? {
        return nil
    }
    
    func setRefreshToken(newValue: String) {}
    
    func clearRefreshToken() {}
    
    func getLoginState() -> MyProduct.LoginState {
        return .logined
    }
    
    func getUserInfo() -> MyProduct.UserResponse? {
        return .init()
    }
    
    func setUserInfo(newValue: MyProduct.UserResponse) {}
    
    func clearUserInfo() {}
    
}
