//
//  LoginInteractor.swift
//  VIPPER
//
//  Created by Manh Pham on 3/4/21.
//

import UIKit

protocol LoginInteractorInterface {
    func getURLAuthen() -> Observable<URL>
    func login(url: URL) -> Observable<Void>
}

final class LoginInteractor {

    @Injected var getURLAuthenUseCaseInterFace: GETURLAuthenUseCaseInterFace
    @Injected var loginUseCase: LoginUseCaseInterface

    deinit {
        if Configs.shared.loggingDeinitEnabled {
            LogInfo("\(Swift.type(of: self)) Deinit")
        }
    }
}

extension LoginInteractor: LoginInteractorInterface {
    func getURLAuthen() -> Observable<URL> {
        getURLAuthenUseCaseInterFace.getURLAuthen()
    }
    
    func login(url: URL) -> Observable<Void> {
        loginUseCase.login(url: url)
    }
}
