//
//  UserRepositoryMock.swift
//  MyAppTests
//
//  Created by Manh Pham on 05/12/2022.
//

import Foundation
import RxSwift
@testable import My_App_Debug

class UserRepositoryMock: UserRepositoryInterface {
    func login(email: String, password: String) -> Single<LoginResponse> {
        return .just(.init(token: "testToken", refreshToken: "testRefreshToken"))
    }

    func userInfo() -> Single<UserResponse> {
        return .just(.init(email: "test@test.com", name: "test"))
    }

    func refreshToken(token: String) -> Single<RefreshTokenResponse> {
        return .just(.init(status: "test", token: "test"))
    }
}
