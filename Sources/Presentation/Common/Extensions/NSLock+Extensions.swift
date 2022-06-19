//
//  NSLock+Extensions.swift
//  MyApp
//
//  Created by Manh Pham on 6/19/22.
//

import Foundation

extension NSLock {
    
    func lock<T>(_ block: () throws -> T) rethrows -> T {
        lock()
        defer { unlock() }
        return try block()
    }
    
}
