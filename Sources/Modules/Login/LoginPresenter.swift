//
//  LoginPresenter.swift
//  VIPPER
//
//  Created by Manh Pham on 3/4/21.
//

protocol LoginPresenterInterface {
    var view: LoginViewInterface? { get }
    var router: LoginRouterInterface { get }
    var interactor: LoginInteractorInterface { get }
    func inject(view: LoginViewInterface)
    
    func didTapLoginButton()
}

final class LoginPresenter: LoginPresenterInterface, HasDisposeBag, HasActivityIndicator {

    weak var view: LoginViewInterface?
    @Injected var router: LoginRouterInterface
    @Injected var interactor: LoginInteractorInterface

    let activityIndicator = ActivityIndicator.shared
    let trigger = PublishRelay<Void>()

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
            .getURLAuthen()
            .trackActivity(activityIndicator)
            .flatMap { [weak self] url -> Observable<Void> in
                guard let self = self else { return .empty() }
                return self.interactor.login(url: url).trackActivity(self.activityIndicator)
            }
            .do(onError: { [weak self] error in
                guard let self = self else { return }
                guard let error = error as? LoginUseCaseError else { return }
                self.view?.showAlert(title: "Error", message: error.message)
            })
            .asDriverOnErrorJustComplete()
            .drive(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.router.navigationToHomeScreen()
            })
            .disposed(by: disposeBag)
    }
    
}
