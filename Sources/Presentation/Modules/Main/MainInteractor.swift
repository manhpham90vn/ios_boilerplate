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
    func cleanData()
    func getDataPaging(page: Int) -> Single<[Paging]>
    func getUserInfo() -> Single<User>
}

final class MainInteractor: MainInteractorInterface {

    @Injected var getEventUseCaseInterface: GETEventUseCaseInterface
    @Injected var cleanUserInfoUseCaseInterface: CleanUserInfoUseCaseInterface
    @Injected var getUserInfoUseCase: GETUserInfoUseCase

    deinit {
        if Configs.shared.loggingDeinitEnabled {
            LogInfo("\(Swift.type(of: self)) Deinit")
        }
    }

    func cleanData() {
        cleanUserInfoUseCaseInterface.clean()
    }

    func getDataPaging(page: Int) -> Single<[Paging]> {
        getEventUseCaseInterface.paging(page: page)
    }
    
    func getUserInfo() -> Single<User> {
        getUserInfoUseCase.getInfo()
    }

}
