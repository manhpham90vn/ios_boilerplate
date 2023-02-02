//
//  LoginUseCaseTests.swift
//  MyiOSAppTests
//
//  Created by Manh Pham on 12/30/21.
//

import Mockingbird
import RxSwift

@testable import MyProduct

final class LoginUseCaseTests: XCTestCase {
    
    var repo: UserRepositoryInterfaceMock!
    var local: LocalStorageRepositoryMock!
    var connect: ConnectivityServiceMock!
    
    var loginUseCase: LoginUseCase!
    
    override func setUp() {
        super.setUp()
        
        repo = mock(UserRepositoryInterface.self)
        local = mock(LocalStorageRepository.self)
        connect = mock(ConnectivityService.self)
        
        loginUseCase = LoginUseCase()
        
        loginUseCase.repo = repo
        loginUseCase.local = local
        loginUseCase.connectivityService = connect
    }
    
    override func tearDown() {
        super.tearDown()
        
        repo = nil
        local = nil
        connect = nil
        loginUseCase = nil
    }
    
    func testLoginSuccess() {
        given(repo.login(email: any(), password: any()))
            .willReturn(.just(.init(token: "token", refreshToken: "refreshToken")))
        given(connect.isNetworkConnection).willReturn(true)
        
        let recorder = Recorder<Void>()
        recorder.onNext(valueSubject: loginUseCase.succeeded)

        loginUseCase.execute(params: .init(email: "", password: ""))

        verify(local.setAccessToken(newValue: "token")).wasCalled(exactly(1))
        verify(local.setRefreshToken(newValue: "refreshToken")).wasCalled(exactly(1))
        XCTAssertEqual(recorder.items.count, 1)
    }
    
    func testLoginError() {
        given(connect.isNetworkConnection)
            .willReturn(true)
        given(repo.login(email: any(), password: any()))
            .willReturn(.error(MyProduct.AppError.noInternetConnection))
        
        let recorder = Recorder<Error>()
        recorder.onNext(valueSubject: loginUseCase.failed)

        loginUseCase.execute(params: .init(email: "", password: ""))

        verify(local.setAccessToken(newValue: "token")).wasNeverCalled()
        verify(local.setRefreshToken(newValue: "refreshToken")).wasNeverCalled()
        XCTAssertEqual(recorder.items.count, 1)
    }
    
    func testLoginError1() {
        given(connect.isNetworkConnection)
            .willReturn(false)
        
        let recorder = Recorder<Error>()
        recorder.onNext(valueSubject: loginUseCase.failed)

        loginUseCase.execute(params: .init(email: "", password: ""))

        verify(local.setAccessToken(newValue: "token")).wasNeverCalled()
        verify(local.setRefreshToken(newValue: "refreshToken")).wasNeverCalled()
        XCTAssertEqual(recorder.items.count, 1)
    }
}
