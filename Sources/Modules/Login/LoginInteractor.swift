//
//  LoginInteractor.swift
//  VIPPER
//
//  Created by Manh Pham on 3/4/21.
//

import UIKit

protocol LoginInteractorInterface {
    func getURLAuthen() -> Single<URL>
    func login(url: URL) -> Single<Void>
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
    func getURLAuthen() -> Single<URL> {
        getURLAuthenUseCaseInterFace.getURLAuthen()
    }
    
    func login(url: URL) -> Single<Void> {
        loginUseCase.login(url: url)
    }
}
