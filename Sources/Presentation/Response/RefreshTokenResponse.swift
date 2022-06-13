//
//  RefreshTokenResponse.swift
//  MyApp
//
//  Created by Manh Pham on 6/12/22.
//

import Foundation

struct RefreshTokenResponse: Codable {
    var status: String
    var token: String
}

extension RefreshTokenResponse: EntityConvertibleType {
    func asEntity() -> RefreshToken {
        RefreshToken(token: token)
    }
}
