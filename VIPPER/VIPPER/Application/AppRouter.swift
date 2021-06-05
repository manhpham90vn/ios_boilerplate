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
            return MainRouter().viewController
        case .login:
            return LoginRouter().viewController
        case .detail:
            return DetailRouter().viewController
        }
    }
}
