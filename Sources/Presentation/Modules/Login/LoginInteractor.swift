//
//  LoginInteractor.swift
//  VIPPER
//
//  Created by Manh Pham on 3/4/21.
//

import UIKit
import RxSwift
import RxCocoa
import Resolver

protocol LoginInteractorInterface {
    func login(email: String, password: String) -> Single<Token>
}

final class LoginInteractor {

    @Injected var loginUseCase: LoginUseCaseInterface

    deinit {
        if Configs.shared.loggingDeinitEnabled {
            LogInfo("\(Swift.type(of: self)) Deinit")
        }
    }
}

extension LoginInteractor: LoginInteractorInterface {
    func login(email: String, password: String) -> Single<Token> {
        loginUseCase.login(email: email, password: password)
    }
}
