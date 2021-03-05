//
//  OAuthService.swift
//  VIPPER
//
//  Created by Manh Pham on 3/5/21.
//

import Foundation
import RxSwift
import RxCocoa

protocol OAuthService {
    func getURLAuthen() -> Single<URL>
}

class OAuthServiceComponent: OAuthService {
        
    private var authSession: AuthenticationServices?
    
    func getURLAuthen() -> Single<URL> {
        return Single<URL>.create { (single) in
            self.authSession = SafariExtensionFactory.provideAuthenticationService()
            self.authSession?.initiateSession(url: URL(string: Configs.loginURL)!,
                                              callBackURL: Configs.callbackURLScheme,
                                              completionHandler: { (url, error) in
                                                if let error = error {
                                                    single(.error(error))
                                                    return
                                                }
                                                if let url = url {
                                                    single(.success(url))
                                                } else {
                                                    single(.error(CommonError.emptyData))
                                                }
            })
            self.authSession?.startSession()
            return Disposables.create {
                self.authSession?.cancelSession()
            }
        }
    }
}
