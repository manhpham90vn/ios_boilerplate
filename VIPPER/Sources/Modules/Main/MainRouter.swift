//
//  MainRouter.swift
//  VIPPER
//
//  Created by Manh Pham on 3/5/21.
//

import UIKit
import SwinjectStoryboard

protocol MainRouterInterface {
    func navigationToDetailScreen(item: Event)
    func navigationToLoginScreen()
}

final class MainRouter: MainRouterInterface, Router {

    unowned var viewController: MainViewController

    required init(viewController: MainViewController) {
        self.viewController = viewController
        viewController.presenter = MainPresenter(view: viewController,
                                                 router: self,
                                                 interactor: SwinjectStoryboard.defaultContainer.resolve(MainInteractorInterface.self)!)
    }

    deinit {
        LogInfo("\(type(of: self)) Deinit")
    }

    func navigationToDetailScreen(item: Event) {
        let vc = AppScenes.detail.viewController
        vc.title = item.repo?.name
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigationToLoginScreen() {
        UIWindow.shared?.rootViewController = UINavigationController(rootViewController: AppScenes.login.viewController)
    }

}
