//
//  Presenter.swift
//  StoryApp
//
//  Created by Manh Pham on 15/06/2021.
//

import Foundation

protocol Presenter: AnyObject {
    associatedtype View
    associatedtype Router
    associatedtype Interactor
    var view: View { get }
    var router: Router { get }
    var interactor: Interactor { get }
    init(view: View, router: Router, interactor: Interactor)
}
