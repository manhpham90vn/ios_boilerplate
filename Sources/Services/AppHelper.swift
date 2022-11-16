//
//  AppHelper.swift
//  VIPER
//
//  Created by Manh Pham on 3/2/21.
//

import UIKit

final class AppHelper {
            
    func topViewController(_ viewController: UIViewController? = UIWindow.shared?.rootViewController) -> UIViewController? {
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
