//
//  MyiOSAppTests.swift
//  MyiOSAppTests
//
//  Created by Manh Pham on 12/30/21.
//

import XCTest
import MPInjector
@testable import My_App_Debug

final class MyiOSAppTests: XCTestCase {
    
    @Inject var local: LocalStorageRepository
    
    func testLoginUseCase() {
        let login = LoginUseCase()
        login.execute(params: .init(email: "test", password: "test"))
        XCTAssertEqual(local.getAccessToken(), "testToken")
    }
    
    func testLoginPresenter() {
        let pr = LoginPresenter()
        pr.login.accept("test")
        pr.password.accept("test")
        pr.didTapLoginButton()
        XCTAssertEqual((pr.router as? LoginRouterMock)?.didCallNavigationToHomeScreen, true)
    }
}
