//
//  MainInteractor.swift
//  VIPPER
//
//  Created by Manh Pham on 3/5/21.
//

import Foundation
import RxSwift
import Resolver

protocol MainInteractorInterface {
    var getEventUseCaseInterface: GETEventUseCase { get }
    var cleanUserInfoUseCaseInterface: CleanUserInfoUseCase { get }
    var getUserInfoUseCase: GETUserInfoUseCase { get }
}

final class MainInteractor: MainInteractorInterface {

    @Injected var getEventUseCaseInterface: GETEventUseCase
    @Injected var cleanUserInfoUseCaseInterface: CleanUserInfoUseCase
    @Injected var getUserInfoUseCase: GETUserInfoUseCase

    deinit {
        if Configs.shared.loggingDeinitEnabled {
            LogInfo("\(Swift.type(of: self)) Deinit")
        }
    }
}
