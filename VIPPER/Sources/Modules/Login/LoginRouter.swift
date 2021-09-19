//
//  LoginRouter.swift
//  VIPPER
//
//  Created by Manh Pham on 3/4/21.
//

import UIKit

protocol LoginRouterInterface {
    var view: LoginViewInterface? { get }
    func inject(view: LoginViewInterface)
    
    func navigationToHomeScreen()
}

final class LoginRouter: LoginRouterInterface {

    weak var view: LoginViewInterface?
    
    func inject(view: LoginViewInterface) {
        self.view = view
    }

    deinit {
        if Configs.shared.loggingDeinitEnabled {
            LogInfo("\(Swift.type(of: self)) Deinit")
        }
    }
    
    func navigationToHomeScreen() {
        UIWindow.shared?.rootViewController = UINavigationController(rootViewController: AppScenes.main.viewController)
    }

}
