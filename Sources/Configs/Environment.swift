//
//  Environment.swift
//  MyApp
//
//  Created by Manh Pham on 07/06/2021.
//

import Foundation

enum Environment {
    case develop
    case product

    var clientID: String {
        "ee3f7a1e1e4d1719b770"
    }

    var clientSecrets: String {
        "e9fdb61bad71fe9f25f8c7844ef3303f019e69e0"
    }
    var scopes: String {
        "user+repo+notifications+read:org"
    }

    var loginURL: String {
        "http://github.com/login/oauth/authorize?client_id=\(clientID)&scope=\(scopes)"
    }

    var oauthURL: String {
        "https://github.com"
    }

    var apiURL: String {
        "https://api.github.com"
    }

    var callbackURLScheme: String {
        "manhpv"
    }

}
