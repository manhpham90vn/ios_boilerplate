//
//  MainRouter.swift
//  VIPPER
//
//  Created by Manh Pham on 3/5/21.
//

import UIKit

protocol MainRouterInterface {
    func navigationToDetailScreen(viewController: UIViewController, item: Event)
    func navigationToLoginScreen()
}

final class MainRouter: MainRouterInterface {
    
    deinit {
        if Configs.shared.loggingDeinitEnabled {
            LogInfo("\(Swift.type(of: self)) Deinit")
        }
    }

    func navigationToDetailScreen(viewController: UIViewController, item: Event) {
        let vc = AppScenes.detail(event: item).viewController
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigationToLoginScreen() {
        UIWindow.shared?.rootViewController = UINavigationController(rootViewController: AppScenes.login.viewController)
    }

}
