//
//  LoginPresenterTests.swift
//  MyProductTests
//
//  Created by Manh Pham on 1/9/23.
//

import Foundation
import Mockingbird
import RxSwift
import RxBlocking
import RxTest

@testable import MyProduct

final class LoginPresenterTests: XCTest {
    
    var repo: UserRepositoryInterfaceMock!
    var local: LocalStorageRepositoryMock!
    var loginUseCase: LoginUseCase!
    var connect: ConnectivityServiceMock!
    var view: LoginViewInterfaceMock!
    var route: LoginRouterInterfaceMock!
    var interactor: LoginInteractorInterfaceMock!
    var pr: LoginPresenter!
    
    override func setUp() {
        super.setUp()
        
        repo = mock(UserRepositoryInterface.self)
        local = mock(LocalStorageRepository.self)
        connect = mock(ConnectivityService.self)
        
        loginUseCase = LoginUseCase()
        loginUseCase.repo = repo
        loginUseCase.local = local
        loginUseCase.connectivityService = connect
        
        view = mock(LoginViewInterface.self)
        route = mock(LoginRouterInterface.self)
        interactor = mock(LoginInteractorInterface.self)
        
        pr = LoginPresenter()
        pr.view = view
        pr.router = route
        pr.interactor = interactor
    }
    
    override func tearDown() {
        super.tearDown()
        
        repo = nil
        local = nil
        loginUseCase = nil
        view = nil
        route = nil
        interactor = nil
        pr = nil
    }
                  
    
    func testLogin() {
        given(repo.login(email: any(), password: any()))
            .willReturn(.just(.init(token: "token", refreshToken: "refreshToken")))
        given(connect.isNetworkConnection)
            .willReturn(true)
        given(interactor.loginUseCase)
            .willReturn(loginUseCase)
        
        pr.login.accept("login")
        pr.password.accept("pass")
        
        let recorder = Recorder<Void>()
        recorder.onNext(valueSubject: loginUseCase.succeeded)
        
        pr.didTapLoginButton()
        
        verify(local.setAccessToken(newValue: "token")).wasCalled(exactly(1))
        verify(local.setRefreshToken(newValue: "refreshToken")).wasCalled(exactly(1))
        XCTAssertEqual(recorder.items.count, 1)
    }
}
