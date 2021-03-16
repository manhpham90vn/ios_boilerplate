//
//  AccessTokenParams.swift
//  VIPPER
//
//  Created by Manh Pham on 3/16/21.
//

import Foundation

struct AccessTokenParams: Codable {
    
    var clientId: String
    var clientSecret: String
    var code: String
    var redirectUri: String?
    var state: String?
    
    enum CodingKeys: String, CodingKey {
        case clientId = "client_id"
        case clientSecret = "client_secret"
        case code
        case redirectUri = "redirect_uri"
        case state
    }
    
}
