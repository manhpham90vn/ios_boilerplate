//
//  OAuthService.swift
//  VIPPER
//
//  Created by Manh Pham on 3/5/21.
//

import Foundation

protocol OAuthService {
    func getURLAuthen() -> Single<URL>
}

final class OAuthServiceComponent: OAuthService {
        
    private var authSession: AuthenticationServices?
        
    func getURLAuthen() -> Single<URL> {
        return Single<URL>.create { [weak self] (single) in
            self?.authSession = SafariExtensionFactory.provideAuthenticationService()
            self?.authSession?.initiateSession(url: URL(string: Configs.shared.env.loginURL)!,
                                               callBackURL: Configs.shared.env.callbackURLScheme,
                                               completionHandler: { (url, error) in
                                                if let error = error {
                                                    single(.failure(error))
                                                    return
                                                }
                                                if let url = url {
                                                    single(.success(url))
                                                } else {
                                                    single(.failure(CommonError.emptyData))
                                                }
            })
            self?.authSession?.startSession()
            return Disposables.create {
                self?.authSession?.cancelSession()
            }
        }
    }
        
}
