//
//  PagingResponse.swift
//  MyApp
//
//  Created by Manh Pham on 6/12/22.
//

import Foundation

struct PagingResponse: Codable {
    var array: [PagingUserResponse]
    
    struct PagingUserResponse: Codable {
        var name: String
        var age: Int
    }
}

extension PagingResponse: EntityConvertibleType {
    
    typealias EntityType = [Paging]

    func asEntity() -> [Paging] {
        array.map { Paging(name: $0.name, age: $0.age) }
    }
}
