//
//  AppInjector.swift
//  MyApp
//
//  Created by Manh Pham on 05/12/2022.
//

import Foundation
import MPInjector

@testable import MyProduct

extension MPInjector: RegisteringMock {
    public func registerServiceMock() {
        registerMock { UserRepositoryMock() as UserRepositoryInterface }
        registerMock { LoginRouterMock() as LoginRouterInterface }
        registerMock { LoginViewMock() as LoginViewInterface }
    }
}
