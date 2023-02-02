//
//  LoginPresenterTests.swift
//  MyProductTests
//
//  Created by Manh Pham on 1/9/23.
//

import Foundation
import RxSwift
import RxBlocking
import RxTest
import XCTest

@testable import MyProduct

final class LoginPresenterTests: XCTestCase {
    
    var pr: LoginPresenter!
    
    override func setUp() {
        super.setUp()
        pr = LoginPresenter()
    }
    
    override func tearDown() {
        super.tearDown()
        pr = nil
    }
                  
    func testLoginSuccess() {
        let local = LocalStorageRepositoryMock()
        let repo = UserRepositoryInterfaceMock()
        repo.loginHandler = { _, _ in
            return .just(.init(token: "token", refreshToken: "refreshToken"))
        }
        let connectivityService = ConnectivityServiceMock(isNetworkConnection: true)
        let route = LoginRouterInterfaceMock()
        
        pr.interactor.loginUseCase.local = local
        pr.interactor.loginUseCase.repo = repo
        pr.interactor.loginUseCase.connectivityService = connectivityService
        pr.router = route
        pr.screenType = .login
                
        pr.didTapLoginButton()

        XCTAssertEqual(route.navigationToHomeScreenCallCount, 1)
    }
    
    func testLoginFail() {
        let local = LocalStorageRepositoryMock()
        let repo = UserRepositoryInterfaceMock()
        repo.loginHandler = { _, _ in
            return .just(.init(token: "token", refreshToken: "refreshToken"))
        }
        let connectivityService = ConnectivityServiceMock(isNetworkConnection: false)
        let route = LoginRouterInterfaceMock()
        let error = ApiErrorHandlerMock()
        
        pr.interactor.loginUseCase.local = local
        pr.interactor.loginUseCase.repo = repo
        pr.interactor.loginUseCase.connectivityService = connectivityService
        pr.router = route
        pr.errorHandle = error
        pr.screenType = .login
                
        pr.didTapLoginButton()
        
        XCTAssertEqual(error.handleCallCount, 1)
        guard case AppError.noInternetConnection = error.handleArgValues[0].0 else {
            XCTFail("Error")
            return
        }
        XCTAssertEqual(error.handleArgValues[0].1, .login)
    }
}
