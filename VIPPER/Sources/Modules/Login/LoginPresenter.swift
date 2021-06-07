//
//  LoginPresenter.swift
//  VIPPER
//
//  Created by Manh Pham on 3/4/21.
//

import RxSwift
import RxCocoa

protocol LoginPresenterInterface {
    var view: LoginViewInterface { get set }
    var router: LoginRouterInterface { get set }
    var interactor: LoginInteractorInterface { get set }
    
    func didTapLoginButton()
}

final class LoginPresenter: BasePresenter, LoginPresenterInterface {

    unowned var view: LoginViewInterface
    var router: LoginRouterInterface
    var interactor: LoginInteractorInterface

    init(view: LoginViewInterface,
         router: LoginRouterInterface,
         interactor: LoginInteractorInterface) {
        self.view = view
        self.router = router
        self.interactor = interactor
        super.init()

        activityIndicator
            .asSharedSequence()
            .drive(onNext: { [weak self] isLoading in
                guard let self = self else { return }
                self.view.showLoading(isLoading: isLoading)
            })
            .disposed(by: rx.disposeBag)
    }

    deinit {
        LogInfo("\(type(of: self)) Deinit")
        LeakDetector.instance.expectDeallocate(object: router as AnyObject)
        LeakDetector.instance.expectDeallocate(object: interactor as AnyObject)
    }

    func didTapLoginButton() {
        interactor
            .getURLAuthen()
            .trackActivity(activityIndicator)
            .flatMapLatest({ [weak self] url -> Driver<Token> in // need weak self here becase interactor have strong reference to AuthenticationServices
                guard let self = self else { return .empty() }
                guard let code = url.queryParameters?["code"] else {
                    self.view.showAlert(title: "Error", message: "Can not get code")
                    return .empty()
                }
                let params = AccessTokenParams(clientId: Configs.shared.env.clientID,
                                               clientSecret: Configs.shared.env.clientSecrets,
                                               code: code)
                return self.interactor.createAccessToken(params: params)
                    .trackActivity(self.activityIndicator)
                    .do(onError: { error in
                        self.view.showAlert(title: "Error", message: error.localizedDescription)
                    })
                    .asDriver(onErrorDriveWith: .empty())
            })
            .asDriver(onErrorDriveWith: .empty())
            .do(onNext: { token in
                if let token = token.accessToken {
                    self.interactor.saveToken(token: token)
                } else {
                    self.view.showAlert(title: "Error", message: "Can not get access token")
                }
            })
            .asDriver(onErrorDriveWith: .empty())
            .flatMap({ _ -> Driver<User> in
                return self.interactor.getInfo()
                    .trackActivity(self.activityIndicator)
                    .do(onError: { error in
                        self.view.showAlert(title: "Error", message: error.localizedDescription)
                    })
                    .asDriver(onErrorDriveWith: .empty())
            })
            .drive(onNext: { user in
                self.interactor.saveUserInfo(user: user)
                self.router.navigationToHomeScreen()
            })
            .disposed(by: rx.disposeBag)
        
    }
    
}
