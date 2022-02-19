//
//  Encodable+Extensions.swift
//  VIPPER
//
//  Created by Manh Pham on 3/16/21.
//

import Moya

extension Encodable {

    var dictionary: [String: Any]? {
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(self) {
            return try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
        }
        return nil
    }
    
    var data: [Moya.MultipartFormData] {
        guard let dictionary = dictionary else { return [] }
        var result = [Moya.MultipartFormData]()
        dictionary.forEach {
            if let valueString = $0.value as? String, let valueData = valueString.data(using: .utf8) {
                result.append(MultipartFormData(provider: .data(valueData), name: $0.key))
            }
            if let valueInt = $0.value as? Int, let valueData = String(valueInt).data(using: .utf8) {
                result.append(MultipartFormData(provider: .data(valueData), name: $0.key))
            }
            if let valueDouble = $0.value as? Double, let valueData = String(valueDouble).data(using: .utf8) {
                result.append(MultipartFormData(provider: .data(valueData), name: $0.key))
            }
        }
        return result
    }
    
}
