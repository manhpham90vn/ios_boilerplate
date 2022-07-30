//
//  LoginPresenter.swift
//  VIPPER
//
//  Created by Manh Pham on 3/4/21.
//

import RxSwift
import RxCocoa
import NSObject_Rx
import Resolver

protocol LoginPresenterInterface {
    var view: LoginViewInterface? { get }
    var router: LoginRouterInterface { get }
    var interactor: LoginInteractorInterface { get }
    func inject(view: LoginViewInterface)
    
    func didTapLoginButton()
    var login: BehaviorRelay<String> { get }
    var password: BehaviorRelay<String> { get }
}

final class LoginPresenter: LoginPresenterInterface, HasDisposeBag, HasTrigger {

    weak var view: LoginViewInterface?
    @Injected var router: LoginRouterInterface
    @Injected var interactor: LoginInteractorInterface

    let trigger = PublishRelay<Void>()
    
    let login = BehaviorRelay<String>(value: "")
    let password = BehaviorRelay<String>(value: "")

    init() {
        interactor
            .loginUseCase
            .processing
            .drive(onNext: { result in LoadingHelper.shared.isLoading.accept(result) })
            .disposed(by: disposeBag)
        
        interactor
            .loginUseCase
            .succeeded
            .drive(onNext: { [weak self] result in
                if result.token != nil {
                    self?.router.navigationToHomeScreen()
                }
            })
            .disposed(by: disposeBag)
        
        interactor
            .loginUseCase
            .failed
            .drive(onNext: { error in
                AppHelper.shared.showAlert(title: "Error", message: "Login Error: \(error.localizedDescription)", completion: nil)
            })
            .disposed(by: disposeBag)
    }
    
    deinit {
        if Configs.shared.loggingDeinitEnabled {
            LogInfo("\(Swift.type(of: self)) Deinit")
        }
        LeakDetector.instance.expectDeallocate(object: router as AnyObject)
        LeakDetector.instance.expectDeallocate(object: interactor as AnyObject)
    }

    func inject(view: LoginViewInterface) {
        self.view = view
        self.router.inject(view: view)
    }
    
    func didTapLoginButton() {
        interactor
            .loginUseCase
            .execute(params: .init(email: login.value, password: password.value))
    }
    
    func didTapSkipButton() {
        router.navigationToHomeScreen()
    }
    
}
