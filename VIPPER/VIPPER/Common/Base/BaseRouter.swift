//
//  BaseRouter.swift
//  VIPPER
//
//  Created by Manh Pham on 3/5/21.
//

import Foundation
import UIKit

protocol Router {
    var viewController: UIViewController { get set }
}

extension Router {
    var viewController: UIViewController {
        get {
            return UIViewController()
        }
        set {

        }
    }
}

class BaseRouter: NSObject {
    
    deinit {
        print("\(type(of: self)) Deinit")
    }
    
}

extension BaseRouter: Router {}
