//
//  ServerErrorResponse.swift
//  MyApp
//
//  Created by Manh Pham on 6/15/22.
//

import Foundation

struct ServerErrorResponse: Codable {
    var status: String
    var message: String
}

extension ServerErrorResponse: EntityConvertibleType {
    func asEntity() -> ServerError {
        ServerError(status: status, message: message)
    }
}
