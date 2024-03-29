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

protocol LoginPresenterInterface: HasTrigger, HasScreenType {
    var view: LoginViewInterface? { get }
    var router: LoginRouterInterface { get }
    var interactor: LoginInteractorInterface { get }
    var screenType: ScreenType! { get }
    func inject(view: LoginViewInterface, screenType: ScreenType)
    
    var login: BehaviorRelay<String> { get }
    var password: BehaviorRelay<String> { get }
}

final class LoginPresenter: LoginPresenterInterface, HasDisposeBag {

    // dependency
    weak var view: LoginViewInterface?
    @Inject var router: LoginRouterInterface
    @Inject var interactor: LoginInteractorInterface
    @Inject var loading: LoadingHelper
    @Inject var errorHandle: ApiErrorHandler

    // local variable
    var screenType: ScreenType!
    
    // input
    let trigger = PublishRelay<Void>()
    let login = BehaviorRelay<String>(value: "")
    let password = BehaviorRelay<String>(value: "")
    
    init() {        
        trigger
            .withUnretained(self)
            .map {
                LoginUseCaseParams(email: $0.0.login.value, password: $0.0.password.value)
            }
            .bind(to: interactor.loginUseCase.trigger)
            .disposed(by: disposeBag)
        
        interactor.loginUseCase.processing
            .drive(onNext: { [weak self] result in
                self?.loading.isLoading.accept(result)
            })
            .disposed(by: disposeBag)
        
        interactor.loginUseCase.succeeded
            .drive(onNext: { [weak self] in
                self?.router.navigationToHomeScreen()
            })
            .disposed(by: disposeBag)
        
        interactor.loginUseCase.failed
            .drive(onNext: { [weak self] error in
                guard let self = self else { return }
                self.errorHandle.handle(error: error, screenType: self.screenType) { [weak self] in
                    self?.interactor.loginUseCase.retry()
                }
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

    func inject(view: LoginViewInterface, screenType: ScreenType) {
        self.view = view
        self.screenType = screenType
        self.router.inject(view: view)
    }
    
    func didTapLoginButton() {
        trigger.accept(())
    }
}
