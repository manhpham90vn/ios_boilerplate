//
//  LoginRouterMock.swift
//  MyAppTests
//
//  Created by Manh Pham on 05/12/2022.
//

import Foundation
@testable import MyProduct

final class LoginRouterMock: LoginRouterInterface {

    weak var view: LoginViewInterface?
    var didCallNavigationToHomeScreen = false
    
    func inject(view: LoginViewInterface) {}
    
    func navigationToHomeScreen() {
        didCallNavigationToHomeScreen = true
    }
}

