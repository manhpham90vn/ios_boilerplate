//
//  MainRouter.swift
//  VIPPER
//
//  Created by Manh Pham on 3/5/21.
//

import UIKit

protocol MainRouterInterface {
    func navigationToDetailScreen(item: Event)
    func navigationToLoginScreen()
}

class MainRouter: MainRouterInterface, Router {

    unowned var viewController: MainViewController

    required init(viewController: MainViewController) {
        self.viewController = viewController
        viewController.presenter = MainPresenter(view: viewController,
                                                     router: self,
                                                     interactor: MainInteractor(restfulService: RESTfulServiceComponent()))
    }

    deinit {
        print("\(type(of: self)) Deinit")
    }

    func navigationToDetailScreen(item: Event) {
        let vc = AppRouter.detail.viewController
        vc.title = item.repo?.name
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigationToLoginScreen() {
        UIWindow.shared?.rootViewController = UINavigationController(rootViewController: AppRouter.login.viewController)
    }

}
