//
//  User.swift
//  MVC
//
//  Created by Manh Pham on 2/8/21.
//

import Foundation

struct User: Codable {
    
    var id: Double?
    var name: String?
    var login: String?
    var email: String?
    var avatar: String?
    var url: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case login
        case email
        case avatar = "avatar_url"
        case url
    }
    
}
