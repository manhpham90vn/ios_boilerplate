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

class LoginPresenter: BasePresenter, LoginPresenterInterface {
    
    init(view: LoginViewInterface,
         router: LoginRouterInterface,
         interactor: LoginInteractorInterface) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
        
    unowned var view: LoginViewInterface
    var router: LoginRouterInterface
    var interactor: LoginInteractorInterface
    
    private let bag = DisposeBag()
    
    func didTapLoginButton() {
        interactor
            .getURLAuthen()
            .asObservable()
            .flatMapLatest({ [weak self] url -> Driver<Token> in // need weak self here becase interactor have strong reference to AuthenticationServices
                guard let self = self else { return .empty() }
                guard let code = url.queryParameters?["code"] else {
                    self.view.showAlert(title: "Error", message: "Can not get code")
                    return .empty()
                }
                let params = AccessTokenParams(clientId: Configs.shared.clientID,
                                               clientSecret: Configs.shared.ClientSecrets,
                                               code: code)
                return self.interactor.createAccessToken(params: params)
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
            .flatMap({ token -> Driver<User> in
                return self.interactor.getInfo()
                    .do(onError: { error in
                        self.view.showAlert(title: "Error", message: error.localizedDescription)
                    })
                    .asDriver(onErrorDriveWith: .empty())
            })
            .drive(onNext: { user in
                self.interactor.saveUserInfo(user: user)
                self.router.navigationToHomeScreen()
            })
            .disposed(by: bag)
        
    }
    
}
