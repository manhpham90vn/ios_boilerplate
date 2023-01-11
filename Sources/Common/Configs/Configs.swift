//
//  Configs.swift
//  MyApp
//
//  Created by Manh Pham on 3/14/20.
//

import Foundation

public final class Configs {
    
    public static let shared = Configs()

    public let loggingAPIEnabled = false
    public let loggingcURLEnabled = false
    public let loggingToFileEnabled = false
    public let loggingDeinitEnabled = false
    
    public var env: Environment {
        #if DEBUG
        return .develop
        #else
        return .product
        #endif
    }

}
