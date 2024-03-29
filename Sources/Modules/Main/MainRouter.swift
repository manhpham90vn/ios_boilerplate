//
//  MainRouter.swift
//  VIPPER
//
//  Created by Manh Pham on 3/5/21.
//

import UIKit
import MPInjector

/// @mockable
protocol MainRouterInterface {
    var view: MainViewInterface? { get }
    func inject(view: MainViewInterface)
    
    func navigationToDetailScreen(user: PagingUserResponse)
    func navigationToLoginScreen()
}

final class MainRouter: MainRouterInterface {
    
    weak var view: MainViewInterface?
    
    func inject(view: MainViewInterface) {
        self.view = view
    }
    
    deinit {
        if Configs.shared.loggingDeinitEnabled {
            LogInfo("\(Swift.type(of: self)) Deinit")
        }
    }

    func navigationToDetailScreen(user: PagingUserResponse) {
        guard let viewController = view as? MainViewController else { return }
        let vc = AppScenes.detail(params: .init(user: user)).viewController
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigationToLoginScreen() {
        UIWindow.shared?.rootViewController = UINavigationController(rootViewController: AppScenes.login.viewController)
    }

}
