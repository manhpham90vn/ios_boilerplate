//
//  SwiftyUserDefaults+Extensions.swift
//  MyApp
//
//  Created by Manh Pham on 7/19/22.
//

import Foundation
import SwiftyUserDefaults

extension Token: DefaultsSerializable {}
extension RefreshToken: DefaultsSerializable {}
extension User: DefaultsSerializable {}
extension LoginState: DefaultsSerializable {
    static var _defaults: DefaultsCodableBridge<LoginState> {
        return DefaultsCodableBridge<LoginState>()
    }
    
    static var _defaultsArray: DefaultsCodableBridge<[LoginState]> {
        return  DefaultsCodableBridge<[LoginState]>()
    }
}

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
