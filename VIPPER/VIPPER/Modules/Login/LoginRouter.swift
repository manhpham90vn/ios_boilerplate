//
//  LoginRouter.swift
//  VIPPER
//
//  Created by Manh Pham on 3/4/21.
//

import UIKit

protocol LoginRouterInterface {
    func createLoginScreen(view: LoginViewInterface)
    func navigationToHomeScreen()
}

class LoginRouter: LoginRouterInterface {
    
    func createLoginScreen(view: LoginViewInterface) {
        let pr = LoginPresenter(view: view,
                                router: self,
                                interactor: LoginInteractor(service: RESTfulServiceComponent(),
                                                            oauthService: OAuthServiceComponent()))
        view.presenter = pr
    }
    
    func navigationToHomeScreen() {
        UIWindow.shared?.rootViewController = UINavigationController(rootViewController: MainViewController.instantiate)
    }
    
    deinit {
        print("\(type(of: self)) Deinit")
    }
    
}
