//
//  LoginUseCaseTests.swift
//  MyiOSAppTests
//
//  Created by Manh Pham on 12/30/21.
//

import Quick
import Nimble
import Mockingbird

@testable import MyProduct

final class LoginUseCaseTests: QuickSpec {
    override func spec() {
        var repo: UserRepositoryInterfaceMock!
        var local: LocalStorageRepositoryMock!
        var loginUseCase: LoginUseCase!
        
        beforeSuite {
            repo = mock(UserRepositoryInterface.self)
            local = mock(LocalStorageRepository.self)
            loginUseCase = LoginUseCase()
            loginUseCase.repo = repo
            loginUseCase.local = local
        }
        describe("Test LoginUseCase Success") {
            beforeEach {
                given(repo.login(email: any(), password: any()))
                    .willReturn(.just(.init(token: "token", refreshToken: "refreshToken")))
            }
            it("Test Success") {
                loginUseCase.execute(params: .init(email: "", password: ""))
                verify(local.setAccessToken(newValue: "token")).wasCalled(exactly(1))
                verify(local.setRefreshToken(newValue: "refreshToken")).wasCalled(exactly(1))
            }
            afterEach {
                reset(repo)
                reset(local)
            }
        }
        
        describe("Test LoginUseCase Error") {
            beforeEach {
                given(repo.login(email: any(), password: any()))
                    .willReturn(.error(MyProduct.AppError.noInternetConnection))
            }
            it("Test Error") {
                loginUseCase.execute(params: .init(email: "", password: ""))
                verify(local.setAccessToken(newValue: "token")).wasNeverCalled()
                verify(local.setRefreshToken(newValue: "refreshToken")).wasNeverCalled()
            }
            afterEach {
                reset(repo)
                reset(local)
            }
        }
        afterSuite {
            repo = nil
            local = nil
            loginUseCase = nil
        }
    }
}
