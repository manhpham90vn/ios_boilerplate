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

class MainRouter: BaseRouter, MainRouterInterface {

    private(set) unowned var viewController: MainViewController

    override init() {
        viewController = UIStoryboard(name: "Home", bundle: nil).instantiateInitialViewController() as! MainViewController
        super.init()
        viewController.presenter = MainPresenter(view: viewController,
                                                     router: self,
                                                     interactor: MainInteractor(restfulService: RESTfulServiceComponent()))
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
