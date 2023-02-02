//
//  LoginUseCaseTests.swift
//  MyiOSAppTests
//
//  Created by Manh Pham on 12/30/21.
//

import RxSwift
import XCTest

@testable import MyProduct

final class LoginUseCaseTests: XCTestCase {
    
    var loginUseCase: LoginUseCase!

    override func setUp() {
        super.setUp()
        loginUseCase = LoginUseCase()
    }

    override func tearDown() {
        super.tearDown()
        loginUseCase = nil
    }

    func testLoginSuccess() {
        let local = LocalStorageRepositoryMock()
        let repo = UserRepositoryInterfaceMock()
        repo.loginHandler = { _, _ in
            return .just(.init(token: "token", refreshToken: "refreshToken"))
        }
        let connectivityService = ConnectivityServiceMock(isNetworkConnection: true)
        
        loginUseCase.local = local
        loginUseCase.repo = repo
        loginUseCase.connectivityService = connectivityService
        
        let recorder = Recorder<Void>()
        recorder.onNext(valueSubject: loginUseCase.succeeded)

        loginUseCase.execute(params: .init(email: "email@email.com", password: "password"))

        XCTAssertEqual(recorder.items.count, 1)
        XCTAssertEqual(local.setAccessTokenCallCount, 1)
        XCTAssertEqual(local.setAccessTokenArgValues[0], "token")
        XCTAssertEqual(local.setRefreshTokenCallCount, 1)
        XCTAssertEqual(local.setRefreshTokenArgValues[0], "refreshToken")
    }
    
    func testLoginError() {
        let local = LocalStorageRepositoryMock()
        let repo = UserRepositoryInterfaceMock()
        repo.loginHandler = { _, _ in
            return .just(.init())
        }
        let connectivityService = ConnectivityServiceMock(isNetworkConnection: false)
        
        loginUseCase.local = local
        loginUseCase.repo = repo
        loginUseCase.connectivityService = connectivityService
        
        let recorder = Recorder<Error>()
        recorder.onNext(valueSubject: loginUseCase.failed)

        loginUseCase.execute(params: .init(email: "", password: ""))

        XCTAssertEqual(recorder.items.count, 1)
        guard case AppError.noInternetConnection = recorder.items[0] else {
            XCTFail("Error")
            return
        }
        XCTAssertEqual(local.setAccessTokenCallCount, 0)
        XCTAssertEqual(local.setRefreshTokenCallCount, 0)
    }
}
