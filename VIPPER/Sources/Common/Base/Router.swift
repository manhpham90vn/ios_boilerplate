//
//  Router.swift
//  VIPPER
//
//  Created by Manh Pham on 3/5/21.
//

protocol Router: AnyObject {
    associatedtype ViewController

    var viewController: ViewController { get set }

    init(viewController: ViewController)
}
