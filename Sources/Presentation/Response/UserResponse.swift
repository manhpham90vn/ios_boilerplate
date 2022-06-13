//
//  UserResponse.swift
//  MyApp
//
//  Created by Manh Pham on 6/12/22.
//

import Foundation

struct UserResponse: Codable {
    var email: String
    var name: String
}

extension UserResponse: EntityConvertibleType {
    func asEntity() -> User {
        User(email: email, name: name)
    }
}
