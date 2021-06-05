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

class LoginRouter: BaseRouter, LoginRouterInterface {

    private(set) unowned var viewController: LoginViewController

    func navigationToHomeScreen() {
        UIWindow.shared?.rootViewController = UINavigationController(rootViewController: AppRouter.main.viewController)
    }

    override init() {
        viewController = UIStoryboard(name: "Login", bundle: nil).instantiateInitialViewController() as! LoginViewController
        super.init()
        viewController.presenter = LoginPresenter(view: viewController,
                                      router: self,
                                      interactor: LoginInteractor(service: RESTfulServiceComponent(),
                                                                  oauthService: OAuthServiceComponent()))
    }
        
}
