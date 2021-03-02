//
//  AuthManager.swift
//  MVC
//
//  Created by Manh Pham on 3/2/21.
//

import Foundation

class AuthManager {
    
    static let shared = AuthManager()
    private init() {}
    
    private let userDefaults = UserDefaults.standard
    private let keyToken = "keyToken"
    private let keyUser = "keyUser"
    
    var token: String? {
        get {
            return userDefaults.value(forKey: keyToken) as? String
        }
        set {
            return userDefaults.set(newValue, forKey: keyToken)
        }
    }
    
    var user: User? {
        get {
            guard let data = userDefaults.value(forKey: keyUser) as? Data else { return nil }
            guard let user = try? PropertyListDecoder().decode(User.self, from: data) else { return nil }
            return user
        }
        set {
            guard let data = try? PropertyListEncoder().encode(newValue) else { return }
            userDefaults.set(data, forKey: keyUser)
        }
    }
    
    var isLogin: Bool {
        return token != nil && user != nil
    }
    
    func logOut() {
        userDefaults.removeObject(forKey: keyToken)
        userDefaults.removeObject(forKey: keyUser)
        lougOutWebView()
    }
    
    func lougOutWebView() {
        URLCache.shared.removeAllCachedResponses()
        URLCache.shared.diskCapacity = 0
        URLCache.shared.memoryCapacity = 0
        HTTPCookieStorage.shared.cookies?.forEach(HTTPCookieStorage.shared.deleteCookie)
        HTTPCookieStorage.shared.removeCookies(since: Date.distantPast)
    }
    
}
