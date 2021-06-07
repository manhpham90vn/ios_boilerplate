//
//  Configs.swift
//  MyApp
//
//  Created by Manh Pham on 3/14/20.
//

import Foundation

final class Configs {
    
    static let shared = Configs()

    let loggingEnabled = false
    var env: Environment {
        #if DEBUG
        return .develop
        #else
        return .product
        #endif
    }

}
