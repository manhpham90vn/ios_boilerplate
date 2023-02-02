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
        loginUseCase.local = LocalStorageRepositoryMock()
        loginUseCase.repo = UserRepositoryInterfaceMock()
        loginUseCase.connectivityService = ConnectivityServiceMock()
        
        let recorder = Recorder<Void>()
        recorder.onNext(valueSubject: loginUseCase.succeeded)

        loginUseCase.execute(params: .init(email: "", password: ""))

        XCTAssertEqual(recorder.items.count, 1)
    }
    
    func testLoginError() {
        loginUseCase.local = LocalStorageRepositoryMock()
        loginUseCase.repo = UserRepositoryInterfaceMock()
        loginUseCase.connectivityService = ConnectivityServiceMockError()
        
        let recorder = Recorder<Error>()
        recorder.onNext(valueSubject: loginUseCase.failed)

        loginUseCase.execute(params: .init(email: "", password: ""))

        XCTAssertEqual(recorder.items.count, 1)
    }
    
    func testLoginError1() {
        loginUseCase.local = LocalStorageRepositoryMock()
        loginUseCase.repo = UserRepositoryInterfaceMock()
        loginUseCase.connectivityService = ConnectivityServiceMockError()
        
        let recorder = Recorder<Error>()
        recorder.onNext(valueSubject: loginUseCase.failed)

        loginUseCase.execute(params: .init(email: "", password: ""))

        XCTAssertEqual(recorder.items.count, 1)
    }
}
