//
//  Token.swift
//  VIPER
//
//  Created by Manh Pham on 2/8/21.
//

import Foundation

struct Token: Codable {

    var accessToken: String?
    var tokenType: String?

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
    }
    
}
