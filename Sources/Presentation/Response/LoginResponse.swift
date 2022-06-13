//
//  LoginResponse.swift
//  MyApp
//
//  Created by Manh Pham on 6/12/22.
//

import Foundation

struct LoginResponse: Codable {
    var status: String
    var token: String
    var refreshToken: String
}

extension LoginResponse: EntityConvertibleType {
    func asEntity() -> Token {
        Token(token: token, refreshToken: refreshToken)
    }
}
