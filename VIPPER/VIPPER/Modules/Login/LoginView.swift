//
//  LoginView.swift
//  VIPPER
//
//  Created by Manh Pham on 3/4/21.
//

import UIKit

protocol LoginViewInterface: AnyObject {
    var presenter: LoginPresenterInterface! { get set }
    func showAlert(title: String, message: String)
}
