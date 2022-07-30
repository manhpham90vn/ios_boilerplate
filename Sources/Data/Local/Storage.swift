//
//  Storage.swift
//  MyApp
//
//  Created by Manh Pham on 7/30/22.
//

import Foundation

enum StorageConstants {
    static let token = "token"
    static let refreshToken = "refreshToken"
    static let fcmToken = "fcmToken"
    static let user = "user"
}

enum StorageError: Error {
    case downCastError
}

protocol Storage {
    func setString(key: String, value: String)
    func getString(key: String) -> String?
    
    func setObject<T: Codable>(key: String, value: T) throws
    func getObject<T: Codable>(key: String) throws -> T?
    
    func clear(key: String)
}
