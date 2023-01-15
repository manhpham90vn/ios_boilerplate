//
//  LoginUseCaseTests.swift
//  MyiOSAppTests
//
//  Created by Manh Pham on 12/30/21.
//

import Quick
import Nimble
import Mockingbird
import RxSwift

@testable import MyProduct

final class LoginUseCaseTests: QuickSpec {
    override func spec() {
        var repo: UserRepositoryInterfaceMock!
        var local: LocalStorageRepositoryMock!
        var connect: ConnectivityServiceMock!
        var disposeBag: DisposeBag!
        
        var loginUseCase: LoginUseCase!
        
        beforeSuite {
            repo = mock(UserRepositoryInterface.self)
            local = mock(LocalStorageRepository.self)
            connect = mock(ConnectivityService.self)
            
            disposeBag = DisposeBag()
            loginUseCase = LoginUseCase()
            
            loginUseCase.repo = repo
            loginUseCase.local = local
            loginUseCase.connectivityService = connect
        }
        describe("Test LoginUseCase Success") {
            beforeEach {
                given(repo.login(email: any(), password: any()))
                    .willReturn(.just(.init(token: "token", refreshToken: "refreshToken")))
                given(connect.isNetworkConnection).willReturn(true)
            }
            it("Test Success") {
                loginUseCase.execute(params: .init(email: "", password: ""))
                verify(local.setAccessToken(newValue: "token")).wasCalled(exactly(1))
                verify(local.setRefreshToken(newValue: "refreshToken")).wasCalled(exactly(1))
            }
            afterEach {
                reset(repo)
                reset(local)
                reset(connect)
            }
        }
        
        describe("Test LoginUseCase Error") {
            beforeEach {
                given(connect.isNetworkConnection)
                    .willReturn(true)
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
                reset(connect)
            }
        }
        
        describe("Test LoginUseCase Error 2") {
            beforeEach {
                given(connect.isNetworkConnection)
                    .willReturn(false)
            }
            it("Test Error") {
                loginUseCase.execute(params: .init(email: "", password: ""))
                verify(local.setAccessToken(newValue: "token")).wasNeverCalled()
                verify(local.setRefreshToken(newValue: "refreshToken")).wasNeverCalled()
            }
            afterEach {
                reset(repo)
                reset(local)
                reset(connect)
            }
        }
        
        describe("Test LoginUseCase Error 3") {
            beforeEach {
                given(connect.isNetworkConnection)
                    .willReturn(true)
                given(repo.login(email: any(), password: any()))
                    .willReturn(.just(.init(token: "token", refreshToken: "refreshToken")))
            }
            it("Test Error") {
                loginUseCase.execute(params: .init(email: "", password: ""))
                loginUseCase.execute(params: .init(email: "", password: ""))
                
                loginUseCase.failed
                    .drive(onNext: { result in
                        expect(result).toEventuallyNot(beNil(), timeout: .seconds(1))
                    })
                    .disposed(by: disposeBag)
                
                verify(local.setAccessToken(newValue: "token")).wasCalled(exactly(2))
                verify(local.setRefreshToken(newValue: "refreshToken")).wasCalled(exactly(2))
            }
            afterEach {
                reset(repo)
                reset(local)
                reset(connect)
            }
        }
        
        afterSuite {
            repo = nil
            local = nil
            connect = nil
            loginUseCase = nil
        }
    }
}
