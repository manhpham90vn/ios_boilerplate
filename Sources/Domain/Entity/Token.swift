//
//  Token.swift
//  MyApp
//
//  Created by Manh Pham on 6/12/22.
//

import Foundation

struct Token: Codable, ServerMessageError {
    var token: String?
    var refreshToken: String?
    var status: String?
    var message: String?
}
