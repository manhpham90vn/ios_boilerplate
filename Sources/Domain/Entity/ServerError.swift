//
//  ServerError.swift
//  MyApp
//
//  Created by Manh Pham on 6/15/22.
//

import Foundation

protocol ServerMessageError {
    var status: String? { get }
    var message: String? { get }
}
