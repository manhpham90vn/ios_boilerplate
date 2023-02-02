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
        pr.interactor.loginUseCase.local = LocalStorageRepositoryMock()
        pr.interactor.loginUseCase.repo = UserRepositoryInterfaceMock()
        pr.interactor.loginUseCase.connectivityService = ConnectivityServiceMock()
        
        let recorder = Recorder<Void>()
        recorder.onNext(valueSubject: pr.interactor.loginUseCase.succeeded)
        
        pr.didTapLoginButton()
        
        XCTAssertEqual(recorder.items.count, 1)
    }
    
    func testLoginFail() {
        pr.interactor.loginUseCase.local = LocalStorageRepositoryMock()
        pr.interactor.loginUseCase.repo = UserRepositoryInterfaceMock()
        pr.interactor.loginUseCase.connectivityService = ConnectivityServiceMockError()
        pr.screenType = .login
        
        let recorder = Recorder<Error>()
        recorder.onNext(valueSubject: pr.interactor.loginUseCase.failed)
        
        pr.didTapLoginButton()
        
        XCTAssertEqual(recorder.items.count, 1)
        XCTAssertTrue(pr.errorHandle.dialog.isShowedDialog)
        XCTAssertEqual(pr.errorHandle, <#T##expression2: Equatable##Equatable#>)
    }
}
