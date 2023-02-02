//
//  UserRepositoryInterfaceMock.swift
//  MyProductTests
//
//  Created by manh on 02/02/2023.
//

import Foundation
import RxSwift

@testable import MyProduct

class UserRepositoryInterfaceMock: UserRepositoryInterface {
    func login(email: String, password: String) -> Single<LoginResponse> {
        return .just(.init(token: "token", refreshToken: "refreshToken"))
    }
    
    func userInfo() -> RxSwift.Single<UserResponse> {
        return .just(.init(email: "test@test.com", name: "test"))
    }
    
    func refreshToken(token: String) -> Single<RefreshTokenResponse> {
        return .just(.init(status: "ok", token: "token"))
    }
}
