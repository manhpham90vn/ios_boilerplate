//
//  LoginRouter.swift
//  VIPPER
//
//  Created by Manh Pham on 3/4/21.
//

import UIKit

protocol LoginRouterInterface {
    func navigationToHomeScreen()
}

final class LoginRouter: LoginRouterInterface {

    func navigationToHomeScreen() {
        UIWindow.shared?.rootViewController = UINavigationController(rootViewController: AppScenes.main.viewController)
    }

    deinit {
        if Configs.shared.loggingDeinitEnabled {
            LogInfo("\(Swift.type(of: self)) Deinit")
        }
    }

}
