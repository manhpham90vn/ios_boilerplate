//
//  OAuthService.swift
//  VIPPER
//
//  Created by Manh Pham on 3/5/21.
//

import Foundation

protocol OAuthService {
    func getURLAuthen() -> Observable<URL>
}

final class OAuthServiceComponent: OAuthService {
        
    private var authSession: AuthenticationServices?
        
    func getURLAuthen() -> Observable<URL> {
        return Observable<URL>.create { [weak self] (observer) in
            self?.authSession = SafariExtensionFactory.provideAuthenticationService()
            self?.authSession?.initiateSession(url: URL(string: Configs.shared.env.loginURL)!,
                                               callBackURL: Configs.shared.env.callbackURLScheme,
                                               completionHandler: { (url, error) in
                                                if let error = error {
                                                    observer.on(.error(error))
                                                    return
                                                }
                                                if let url = url {
                                                    observer.on(.next(url))
                                                    observer.on(.completed)
                                                } else {
                                                    observer.on(.error(CommonError.emptyData))
                                                }
            })
            self?.authSession?.startSession()
            return Disposables.create {
                self?.authSession?.cancelSession()
            }
        }
    }
        
}
