//
//  LoginViewController.swift
//  VIPER
//
//  Created by Manh Pham on 2/8/21.
//

import UIKit
import PKHUD

final class LoginViewController: BaseViewController {
    
    @Injected var presenter: LoginPresenterInterface

    deinit {
        if Configs.shared.loggingDeinitEnabled {
            LogInfo("\(Swift.type(of: self)) Deinit")
        }
        LeakDetector.instance.expectDeallocate(object: presenter as AnyObject)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad(view: self)
    }

    override func setupUI() {
        super.setupUI()

        navigationItem.title = "Login"
    }

    override func bindDatas() {
        super.bindDatas()
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        presenter.didTapLoginButton()
    }

}

extension LoginViewController: LoginViewInterface {}
