//
//  LoginViewController.swift
//  MVC
//
//  Created by Manh Pham on 2/8/21.
//

import UIKit
import SafariServices
import RxSwift
import RxCocoa
import AuthenticationServices

class LoginViewController: BaseViewController {

    private let bag = DisposeBag()
    private var authSession: AuthenticationServices?
    
    static var instantiate: LoginViewController {
        let st = UIStoryboard(name: "Login", bundle: nil)
        let vc = st.instantiateInitialViewController() as! LoginViewController
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Login"
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        authSession = SafariExtensionFactory.provideAuthenticationService()
        authSession?.initiateSession(url: URL(string: Configs.loginURL)!, callBackURL: Configs.callbackURLScheme, completionHandler: { [weak self] (url, error) in
            guard let self = self else { return }
            if let error = error {
                AppHelper.shared.showAlert(title: "Error", message: error.localizedDescription)
                return
            }
            guard let code = url?.queryParameters?["code"] else {
                AppHelper.shared.showAlert(title: "Error", message: "Can not get code")
                return
            }
            API.shared.createAccessToken(clientId: Configs.clientID,
                                              clientSecret: Configs.ClientSecrets,
                                              code: code,
                                              redirectUri: nil,
                                              state: nil)
                .do(onError: { error in
                    AppHelper.shared.showAlert(title: "Error", message: error.localizedDescription)
                })
                .asDriver(onErrorDriveWith: .empty())
                .do(onNext: { token in
                    AuthManager.shared.token = token.accessToken
                })
                .flatMap { _ -> Driver<User> in
                    return API.shared.getInfo()
                        .do(onError: { error in
                            AppHelper.shared.showAlert(title: "Error", message: error.localizedDescription)
                        })
                        .asDriver(onErrorDriveWith: .empty())
                }
                .drive(onNext: { user in
                    AuthManager.shared.user = user
                    UIWindow.shared?.rootViewController = UINavigationController(rootViewController: MainViewController.instantiate)
                })
                .disposed(by: self.bag)
        })
        authSession?.startSession()
    }
    
}
