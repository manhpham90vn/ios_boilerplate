//
//  LoginPresenterTests.swift
//  MyProductTests
//
//  Created by Manh Pham on 1/9/23.
//

import Foundation
import Quick
import Nimble
import Mockingbird
import RxSwift
import RxBlocking
import RxTest

@testable import MyProduct

final class LoginPresenterTests: QuickSpec {
    override func spec() {
        var repo: UserRepositoryInterfaceMock!
        var local: LocalStorageRepositoryMock!
        var loginUseCase: LoginUseCase!
        var connect: ConnectivityServiceMock!
        var view: LoginViewInterfaceMock!
        var route: LoginRouterInterfaceMock!
        var interactor: LoginInteractorInterfaceMock!
        var pr: LoginPresenter!
        var disposeBag: DisposeBag!
        
        beforeSuite {
            repo = mock(UserRepositoryInterface.self)
            local = mock(LocalStorageRepository.self)
            connect = mock(ConnectivityService.self)
            
            loginUseCase = LoginUseCase()
            loginUseCase.repo = repo
            loginUseCase.local = local
            loginUseCase.connectivityService = connect
            
            view = mock(LoginViewInterface.self)
            route = mock(LoginRouterInterface.self)
            interactor = mock(LoginInteractorInterface.self)
            
            pr = LoginPresenter()
            pr.view = view
            pr.router = route
            pr.interactor = interactor
            
            disposeBag = DisposeBag()
        }
                
        describe("Test Login Presenter Login Button") {
            beforeEach {
                given(repo.login(email: any(), password: any()))
                    .willReturn(.just(.init(token: "token", refreshToken: "refreshToken")))
                given(connect.isNetworkConnection)
                    .willReturn(true)
                given(interactor.loginUseCase)
                    .willReturn(loginUseCase)
            }
            it("Test Tap Login") {
                pr.login.accept("login")
                pr.password.accept("pass")
                
                pr.interactor.loginUseCase.succeeded
                    .drive(onNext: { result in
                        expect(result).toEventuallyNot(beNil(), timeout: .seconds(1))
                    })
                    .disposed(by: disposeBag)
                
                pr.didTapLoginButton()
            }
            afterEach {
                reset(repo)
                reset(local)
                reset(view)
                reset(route)
                reset(interactor)
            }
        }
        
        afterSuite {
            repo = nil
            local = nil
            loginUseCase = nil
            view = nil
            route = nil
            interactor = nil
            pr = nil
        }
    }
}
