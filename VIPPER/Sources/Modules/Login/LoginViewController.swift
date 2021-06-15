//
//  LoginViewController.swift
//  VIPER
//
//  Created by Manh Pham on 2/8/21.
//

import UIKit
import PKHUD

final class LoginViewController: BaseViewController {
    
    var presenter: LoginPresenter!

    deinit {
        LogInfo("\(type(of: self)) Deinit")
        LeakDetector.instance.expectDeallocate(object: presenter as AnyObject)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Login"
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        presenter.didTapLoginButton()
    }

}

extension LoginViewController: LoginViewInterface {
    func showAlert(title: String, message: String) {
        AppHelper.shared.showAlert(title: title, message: message)
    }

    func showLoading(isLoading: Bool) {
        isLoading ? HUD.show(.progress) : PKHUD.sharedHUD.hide()
    }
}
