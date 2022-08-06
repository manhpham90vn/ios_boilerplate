//
//  UserDefaultsStorage.swift
//  MyApp
//
//  Created by Manh Pham on 7/30/22.
//

import Foundation
import MPInjector

final class UserDefaultsStorage: Storage {

    @Inject var userDefault: UserDefaults

    func setString(key: String, value: String) {
        userDefault.set(value, forKey: key)
    }
    
    func getString(key: String) -> String? {
        userDefault.string(forKey: key)
    }
        
    func setObject<T: Codable>(key: String, value: T) throws {
        guard let data = userDefault.value(forKey: key) as? Data else {
            throw StorageError.downCastError
        }
        do {
            let object = try PropertyListEncoder().encode(data)
            userDefault.set(object, forKey: key)
        }
    }
    
    func getObject<T: Codable>(key: String) throws -> T? {
        guard let data = userDefault.value(forKey: key) as? Data else {
            return nil
        }
        do {
            let object = try PropertyListDecoder().decode(T.self, from: data)
            return object
        }
    }
    
    func clear(key: String) {
        userDefault.removeObject(forKey: key)
    }
    
}
