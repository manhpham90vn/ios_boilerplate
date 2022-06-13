//
//  Environment.swift
//  MyApp
//
//  Created by Manh Pham on 07/06/2021.
//

import Foundation

enum Environment {
    case develop
    case product

    var baseURL: String {
        "http://localhost:3000/"
    }

}
