//
//  Configs.swift
//  MVC
//
//  Created by Manh Pham on 2/8/21.
//

import Foundation

struct Configs {
    static let clientID = "ee3f7a1e1e4d1719b770"
    static let ClientSecrets = "e9fdb61bad71fe9f25f8c7844ef3303f019e69e0"
    static let scopes = "user+repo+notifications+read:org"
    static var loginURL = URL(string: "http://github.com/login/oauth/authorize?client_id=\(clientID)&scope=\(scopes)")!
    static let callbackURLScheme = "manhpv"
}
