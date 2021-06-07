//
//  AppRouter.swift
//  VIPPER
//
//  Created by Manh Pham on 06/06/2021.
//

import Foundation
import UIKit

enum AppRouter {
    case main
    case login
    case detail

    var viewController: UIViewController {
        switch self {
        case .main:
            let vc = UIStoryboard(name: "Home", bundle: nil).instantiateInitialViewController() as! MainViewController
            return MainRouter(viewController: vc).viewController
        case .login:
            let vc = UIStoryboard(name: "Login", bundle: nil).instantiateInitialViewController() as! LoginViewController
            return LoginRouter(viewController: vc).viewController
        case .detail:
            let vc = UIStoryboard(name: "Detail", bundle: nil).instantiateInitialViewController() as! DetailViewController
            return DetailRouter(viewController: vc).viewController
        }
    }
}
