//
//  LoginResponse.swift
//  MyApp
//
//  Created by Manh Pham on 6/12/22.
//

import Foundation

struct LoginResponse: Codable {
    var token: String?
    var refreshToken: String?
}
