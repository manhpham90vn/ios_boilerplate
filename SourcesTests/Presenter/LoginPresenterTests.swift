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

final class LoginPresenterTests: XCTestCase {
    
    var view: LoginViewInterfaceMock!
    var route: LoginRouterInterfaceMock!
    var interactor: LoginInteractorInterfaceMock!
    var pr: LoginPresenter!
    
    override func setUp() {
        super.setUp()
                
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
        
        view = nil
        route = nil
        interactor = nil
        pr = nil
    }
                  
    
    func testLoginSuccess() {
        given(interactor.loginUseCase.succeeded).willReturn(.just(()))
        
        pr.didTapLoginButton()
        
        verify(route.navigationToHomeScreen()).wasNeverCalled()
    }
}
