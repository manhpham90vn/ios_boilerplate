//
//  ErrorCode.swift
//  StoryApp
//
//  Created by Manh Pham on 7/24/21.
//

import Foundation

enum ErrorCode: Int, CaseIterable {
    case success = 200
    case unauthorized = 401
    case forbidden = 403
    case notAllowed = 405
    case serverError = 500

    var isError: Bool {
        switch self {
        case .success:
            return false
        default:
            return true
        }
    }
}
