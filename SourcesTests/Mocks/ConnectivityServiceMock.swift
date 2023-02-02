//
//  ConnectivityServiceMock.swift
//  MyProductTests
//
//  Created by manh on 02/02/2023.
//

import Foundation
import RxSwift

@testable import MyProduct

class ConnectivityServiceMock: ConnectivityService {
    var isNetworkConnection: Bool {
        return true
    }
}

class ConnectivityServiceMockError: ConnectivityService {
    var isNetworkConnection: Bool {
        return false
    }
}
