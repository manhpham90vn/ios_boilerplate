//
//  Environment.swift
//  MyApp
//
//  Created by Manh Pham on 07/06/2021.
//

import Foundation

enum Environment {
    case develop
    case staging
    case product

    var baseURL: String {
        "http://localhost.charlesproxy.com:3000/"
    }

}
