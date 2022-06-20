//
//  LoginViewController.swift
//  VIPER
//
//  Created by Manh Pham on 2/8/21.
//

import UIKit
import Resolver
import RxSwift
import RxCocoa
import RxRelay
import NSObject_Rx

final class LoginViewController: BaseViewController {
    
    @Injected var presenter: LoginPresenterInterface
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    deinit {
        if Configs.shared.loggingDeinitEnabled {
            LogInfo("\(Swift.type(of: self)) Deinit")
        }
        LeakDetector.instance.expectDeallocate(object: presenter as AnyObject)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.inject(view: self)
    }
    
    override func setupUI() {
        super.setupUI()

        navigationItem.title = "Login"
        emailTextField.text = "admin@admin.com"
        passwordTextField.text = "pwd12345"
    }

    override func bindDatas() {
        super.bindDatas()
        
        emailTextField.rx.text.orEmpty.bind(to: presenter.login).disposed(by: disposeBag)
        passwordTextField.rx.text.orEmpty.bind(to: presenter.password).disposed(by: disposeBag)
        
        loginButton.rx.tap.asDriver()
            .drive(onNext: { [weak self] in
                self?.presenter.didTapLoginButton()
            })
            .disposed(by: rx.disposeBag)
    }
}

extension LoginViewController: LoginViewInterface {}