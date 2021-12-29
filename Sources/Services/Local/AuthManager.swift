//
//  AuthManager.swift
//  VIPER
//
//  Created by Manh Pham on 3/2/21.
//

import Foundation
import SwiftyUserDefaults

protocol AuthManagerInterface: AnyObject {
    var token: String? { get set }
    var user: User? { get set }
    var isLogin: Bool { get }

    func logOut()
}

extension DefaultsKeys {
    var token: DefaultsKey<String?> {
        .init("token", defaultValue: nil)
    }

    var user: DefaultsKey<User?> {
        .init("user", defaultValue: nil)
    }
}

final class AuthManager: AuthManagerInterface {

    @SwiftyUserDefault(keyPath: \.token, options: .cached)
    var token: String?

    @SwiftyUserDefault(keyPath: \.user, options: .cached)
    var user: User?
    
    var isLogin: Bool {
        return token != nil && user != nil
    }
    
    func logOut() {
        Defaults.removeAll()
        ResolverScope.cached.reset()
    }

}
