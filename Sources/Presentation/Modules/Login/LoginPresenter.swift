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

final class LoginPresenter: LoginPresenterInterface, HasDisposeBag, HasActivityIndicator {

    weak var view: LoginViewInterface?
    @Injected var router: LoginRouterInterface
    @Injected var interactor: LoginInteractorInterface

    let activityIndicator = ActivityIndicator.shared
    let trigger = PublishRelay<Void>()
    
    let login = BehaviorRelay<String>(value: "")
    let password = BehaviorRelay<String>(value: "")

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
            .login(email: login.value, password: password.value)
            .trackActivity(activityIndicator)
            .do(onError: { error in
                AppHelper.shared.showAlert(title: "Error", message: error.localizedDescription)
            })
            .asDriverOnErrorJustComplete()
            .drive(onNext: { [weak self] result in
                if result.token != nil {
                    self?.router.navigationToHomeScreen()
                } else {
                    AppHelper.shared.showAlert(title: "Error", message: result.message ?? "")
                }
            })
            .disposed(by: disposeBag)
    }
    
    func didTapSkipButton() {
        router.navigationToHomeScreen()
    }
    
}
