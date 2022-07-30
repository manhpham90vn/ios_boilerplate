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
    var loginUseCase: LoginUseCase { get }
}

final class LoginInteractor: LoginInteractorInterface {

    @Injected var loginUseCase: LoginUseCase

    deinit {
        if Configs.shared.loggingDeinitEnabled {
            LogInfo("\(Swift.type(of: self)) Deinit")
        }
    }
}
