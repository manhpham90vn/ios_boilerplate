//
//  LoginInteractor.swift
//  VIPPER
//
//  Created by Manh Pham on 3/4/21.
//

import UIKit
import RxSwift
import RxCocoa
import MPInjector
import Configs
import Logs

protocol LoginInteractorInterface {
    var loginUseCase: LoginUseCase { get }
}

final class LoginInteractor: LoginInteractorInterface {

    @Inject var loginUseCase: LoginUseCase

    deinit {
        if Configs.shared.loggingDeinitEnabled {
            LogInfo("\(Swift.type(of: self)) Deinit")
        }
    }
}
