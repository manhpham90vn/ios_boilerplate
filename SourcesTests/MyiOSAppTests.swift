//
//  MyiOSAppTests.swift
//  MyiOSAppTests
//
//  Created by Manh Pham on 12/30/21.
//

import XCTest
import MPInjector
import RxBlocking
import Networking
import RxTest
import RxSwift
@testable import My_App_Debug

final class MyiOSAppTests: XCTestCase {
    
    @Inject var local: LocalStorageRepository
    
    let bag = DisposeBag()

    func testLoginUseCaseSuccess() {
        XCTContext.runActivity(named: "test login use case success") { _ in
            let ex = expectation(description: "")
            let login = LoginUseCase()
            login.execute(params: .init(email: "test", password: "test"))
            XCTAssertEqual(local.getAccessToken(), "testToken")
            ex.fulfill()
            wait(for: [ex], timeout: 1.0)
        }
    }

    func testLoginUseCaseError() {
        XCTContext.runActivity(named: "test login use case error") { _ in
            let ex = expectation(description: "")
            let login = LoginUseCase()
            login.failed
                .drive(onNext: { error in
                    if let error = error as? AppError {
                        switch error {
                        case .noInternetConnection:
                            ex.fulfill()
                        default:
                            break
                        }
                    }
                })
                .disposed(by: bag)
            login.execute(params: .init(email: "testError", password: "test"))
            wait(for: [ex], timeout: 2)
        }
    }
    
    func testLoginPresenter() {
        XCTContext.runActivity(named: "test login presenter") { _ in
            let ex = expectation(description: "")
            let pr = LoginPresenter()
            pr.login.accept("test")
            pr.password.accept("test")
            pr.didTapLoginButton()
            ex.fulfill()
            wait(for: [ex], timeout: 1.0)
            XCTAssertEqual((pr.router as? LoginRouterMock)?.didCallNavigationToHomeScreen, true)
            // reset state
            (pr.router as? LoginRouterMock)?.didCallNavigationToHomeScreen = false
        }
    }
    
    func testLoginPresenterError() {
        XCTContext.runActivity(named: "test login presenter error") { _ in
            let ex = expectation(description: "")
            let pr = LoginPresenter()
            pr.screenType = .login
            pr.login.accept("testError")
            pr.password.accept("test")
            pr.didTapLoginButton()
            ex.fulfill()
            wait(for: [ex], timeout: 1.0)
            XCTAssertEqual((pr.router as? LoginRouterMock)?.didCallNavigationToHomeScreen, false)
            // reset state
            (pr.router as? LoginRouterMock)?.didCallNavigationToHomeScreen = false
        }
    }
    
    func testLoginPresenterSkip() {
        XCTContext.runActivity(named: "test login presenter skip") { _ in
            let ex = expectation(description: "")
            let pr = LoginPresenter()
            pr.didTapSkipButton()
            ex.fulfill()
            wait(for: [ex], timeout: 1.0)
            XCTAssertEqual((pr.router as? LoginRouterMock)?.didCallNavigationToHomeScreen, true)
            // reset state
            (pr.router as? LoginRouterMock)?.didCallNavigationToHomeScreen = false
        }
    }
}
