//
//  ServerError.swift
//  MyApp
//
//  Created by Manh Pham on 6/15/22.
//

import Foundation

struct ServerError: Codable {
    var status: String
    var message: String
}
