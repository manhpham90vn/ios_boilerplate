//
//  URL+Extensions.swift
//  VIPER
//
//  Created by Manh Pham on 2/8/21.
//

import Foundation

extension URL {

    var queryParameters: [String: String]? {
        guard let components = URLComponents(url: self, resolvingAgainstBaseURL: false),
              let queryItems = components.queryItems else { return nil }

        var items: [String: String] = [:]

        for queryItem in queryItems {
            items[queryItem.name] = queryItem.value
        }

        return items
    }

}
