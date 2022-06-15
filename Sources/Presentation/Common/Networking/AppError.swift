//
//  AppError.swift
//  MyApp
//
//  Created by Manh Pham on 12/31/21.
//

import Foundation

protocol AppError {
    var errorTitle: String? { get }
    var errorMessage: String? { get }
    var buttonLeft: String? { get }
    var buttonRight: String? { get }
    var needHandleError: Bool { get }
}

extension AppError {
    var errorTitle: String? {
        "Đã xảy ra lỗi"
    }
    
    var errorMessage: String? {
        "Vui lòng thử lại"
    }
    
    var buttonLeft: String? {
        "Huỷ bỏ"
    }
    
    var buttonRight: String? {
        "Xác nhận"
    }
    
    var needHandleError: Bool {
        true
    }
}
