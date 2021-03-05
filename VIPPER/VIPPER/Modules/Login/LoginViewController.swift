//
//  LoginViewController.swift
//  MVC
//
//  Created by Manh Pham on 2/8/21.
//

import UIKit

class LoginViewController: BaseViewController {
    
    var presenter: LoginPresenterInterface!
    
    static var instantiate: LoginViewController {
        let st = UIStoryboard(name: "Login", bundle: nil)
        let vc = st.instantiateInitialViewController() as! LoginViewController
        LoginRouter().createLoginScreen(view: vc)
        return vc
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
    
}
