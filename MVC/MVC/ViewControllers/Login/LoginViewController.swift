//
//  LoginViewController.swift
//  MVC
//
//  Created by Manh Pham on 2/8/21.
//

import UIKit
import SafariServices
import RxSwift

class LoginViewController: UIViewController {

    private let bag = DisposeBag()
    private var authSession: SFAuthenticationSession?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Login"
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        authSession = SFAuthenticationSession(url: Configs.loginURL, callbackURLScheme: Configs.callbackURLScheme) { (url, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let code = url?.queryParameters?["code"] else { return }
            let token = API.shared.createAccessToken(clientId: Configs.clientID,
                                              clientSecret: Configs.ClientSecrets,
                                              code: code,
                                              redirectUri: nil,
                                              state: nil)
            token.subscribe(onSuccess: { token in
                print(token)
            }, onFailure: { error in
                print(error.localizedDescription)
            })
            .disposed(by: self.bag)
        }
        authSession?.start()
    }
    
}
