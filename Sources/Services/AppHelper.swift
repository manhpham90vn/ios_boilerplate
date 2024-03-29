//
//  AppHelper.swift
//  VIPER
//
//  Created by Manh Pham on 3/2/21.
//

import UIKit

/// @mockable
protocol AppHelper {
    func topViewController(_ viewController: UIViewController?) -> UIViewController?
}

final class AppHelperImp: AppHelper {
            
    func topViewController(_ viewController: UIViewController?) -> UIViewController? {
        let viewController = viewController ?? UIWindow.shared?.rootViewController
        if let nav = viewController as? UINavigationController {
            return topViewController(nav.visibleViewController)
        }
        if let tab = viewController as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(selected)
            }
        }
        if let presented = viewController?.presentedViewController {
            return topViewController(presented)
        }
        return viewController
    }
    
}
