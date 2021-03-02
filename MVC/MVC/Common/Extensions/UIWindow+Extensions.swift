//
//  UIWindow+Extensions.swift
//  MVC
//
//  Created by Manh Pham on 3/2/21.
//

import UIKit

extension UIWindow {
    
    static var shared: UIWindow? {
        if #available(iOS 13, *) {
            return SceneDelegate.keyWindow
        } else {
            return AppDelegate.keyWindow
        }
    }
    
}
