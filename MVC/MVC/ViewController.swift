//
//  ViewController.swift
//  MVC
//
//  Created by Manh Pham on 2/8/21.
//

import UIKit
import SafariServices
import RxSwift

class ViewController: UIViewController {

    private let bag = DisposeBag()
    private var authSession: SFAuthenticationSession?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.addTarget(self, action: #selector(auth), for: .touchUpInside)
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    @objc
    func auth() {
        authSession = SFAuthenticationSession(url: Configs.loginURL, callbackURLScheme: Configs.callbackURLScheme) { (url, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let code = url?.queryParameters?["code"] else { return }
            let token = API.createAccessToken(clientId: Configs.clientID,
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

public extension URL {

    var queryParameters: [String: String]? {
        guard let components = URLComponents(url: self, resolvingAgainstBaseURL: false), let queryItems = components.queryItems else { return nil }

        var items: [String: String] = [:]

        for queryItem in queryItems {
            items[queryItem.name] = queryItem.value
        }

        return items
    }

}
