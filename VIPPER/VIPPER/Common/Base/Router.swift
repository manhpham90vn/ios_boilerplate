//
//  Router.swift
//  VIPPER
//
//  Created by Manh Pham on 3/5/21.
//

import Foundation

protocol Router: AnyObject {
    associatedtype ViewController: BaseViewController
    var viewController: ViewController { get set }
    init(viewController: ViewController)
}