//
//  Configs.swift
//  MyApp
//
//  Created by Manh Pham on 3/14/20.
//

import Foundation

final class Configs {
    
    static let shared = Configs()

    let loggingAPIEnabled = false
    let loggingLoadingEnabled = false
    let loggingToFileEnabled = false
    let loggingDeinitEnabled = true
    
    var env: Environment {
        #if DEBUG
        return .develop
        #else
        return .product
        #endif
    }

}
