//
//  MainRouter.swift
//  VIPPER
//
//  Created by Manh Pham on 3/5/21.
//

import UIKit

protocol MainRouterInterface {
    func createMainScreen(view: MainViewInterface)
    func navigationToDetailScreen(nav: UINavigationController, item: Event)
    func navigationToLoginScreen()
}

class MainRouter: BaseRouter, MainRouterInterface {
    
    func createMainScreen(view: MainViewInterface) {
        let pr = MainPresenter(view: view,
                               router: self,
                               interactor: MainInteractor(restfulService: RESTfulServiceComponent()))
        view.presenter = pr
    }
    
    func navigationToDetailScreen(nav: UINavigationController, item: Event) {
        let vc = DetailViewController.instantiate
        vc.navigationItem.title = item.repo?.name
        nav.pushViewController(vc, animated: true)
    }
    
    func navigationToLoginScreen() {
        UIWindow.shared?.rootViewController = UINavigationController(rootViewController: LoginViewController.instantiate)
    }
    
}
