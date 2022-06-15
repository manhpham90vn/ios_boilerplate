//
//  Retryable.swift
//  MyApp
//
//  Created by Manh Pham on 6/15/22.
//

import Foundation

protocol Retryable {
    var autoRetry: Bool { get }
}

extension Retryable {
    var autoRetry: Bool {
        false
    }
}
