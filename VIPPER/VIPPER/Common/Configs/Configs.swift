//
//  Configs.swift
//  VIPER
//
//  Created by Manh Pham on 2/8/21.
//

import Foundation
import RxSwift

struct Configs {
    
    static var shared = Configs()
    
    let loggingEnabled = false
    let apiTimeOut = RxTimeInterval.seconds(10)
    
    let clientID = "ee3f7a1e1e4d1719b770"
    let ClientSecrets = "e9fdb61bad71fe9f25f8c7844ef3303f019e69e0"
    let scopes = "user+repo+notifications+read:org"
    
    lazy var loginURL = "http://github.com/login/oauth/authorize?client_id=\(clientID)&scope=\(scopes)"
    let oauthURL = "https://github.com"
    let apiURL = "https://api.github.com"
    let callbackURLScheme = "manhpv"
}
