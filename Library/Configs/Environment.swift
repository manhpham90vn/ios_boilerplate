//
//  Environment.swift
//  MyApp
//
//  Created by Manh Pham on 07/06/2021.
//

import Foundation

public enum Environment {
    case develop
    case staging
    case product

    public var baseURL: String {
        "http://localhost.charlesproxy.com:3000/"
    }

}
