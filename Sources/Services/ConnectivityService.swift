//
//  ConnectivityService.swift
//  MyApp
//
//  Created by Manh Pham on 7/30/22.
//

import Foundation
import Alamofire

/// @mockable
protocol ConnectivityService {
    var isNetworkConnection: Bool { get }
}

final class ConnectivityServiceImpl: ConnectivityService {
    var isNetworkConnection: Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}
