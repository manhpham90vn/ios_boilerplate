//
//  LoginPresenter.swift
//  VIPPER
//
//  Created by Manh Pham on 3/4/21.
//

import RxSwift
import RxCocoa
import NSObject_Rx
import MPInjector

protocol LoginPresenterInterface: HasTrigger {
    var view: LoginViewInterface? { get }
    var router: LoginRouterInterface { get }
    var interactor: LoginInteractorInterface { get }
    func inject(view: LoginViewInterface)
    
    func didTapLoginButton()
    var login: BehaviorRelay<String> { get }
    var password: BehaviorRelay<String> { get }
    var trigger: PublishRelay<Void> { get }
}

final class LoginPresenter: LoginPresenterInterface, HasDisposeBag {

    // dependency
    weak var view: LoginViewInterface?
    @Inject var router: LoginRouterInterface
    @Inject var interactor: LoginInteractorInterface
    @Inject var loading: LoadingHelper
    @Inject var errorHandle: ApiErrorHandler

    // input
    let trigger = PublishRelay<Void>()
    let login = BehaviorRelay<String>(value: "")
    let password = BehaviorRelay<String>(value: "")

    init() {
        interactor
            .loginUseCase
            .processing
            .drive(onNext: { [weak self] result in
                self?.loading.isLoading.accept(result)
            })
            .disposed(by: disposeBag)
        
        interactor
            .loginUseCase
            .succeeded
            .drive(onNext: { [weak self] result in
                if result {
                    self?.router.navigationToHomeScreen()
                }
            })
            .disposed(by: disposeBag)
        
        interactor
            .loginUseCase
            .failed
            .drive(onNext: { [weak self] error in
                self?.errorHandle.handle(error: error)
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
