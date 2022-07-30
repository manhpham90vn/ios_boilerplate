//
//  PagingResponse.swift
//  MyApp
//
//  Created by Manh Pham on 6/12/22.
//

import Foundation

struct PagingResponse: Codable {
    var array: [PagingUserResponse]?
}

struct PagingUserResponse: Codable {
    var name: String?
    var age: Int?
}
