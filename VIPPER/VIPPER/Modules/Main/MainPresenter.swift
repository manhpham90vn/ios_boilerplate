//
//  MainPresenter.swift
//  VIPPER
//
//  Created by Manh Pham on 3/5/21.
//

import UIKit
import RxSwift

protocol MainPresenterInterface {
    var view: MainViewInterface { get set }
    var router: MainRouterInterface { get set }
    var interactor: MainInteractorInterface { get set }
    
    var elements: [Event] { get set }
    func viewDidLoad()
    func didTapLogout()
    func navigationToDetailScreen(item: Event)
}

class MainPresenter: BasePresenter, MainPresenterInterface {

    unowned var view: MainViewInterface
    var router: MainRouterInterface
    var interactor: MainInteractorInterface

    var elements: [Event] = []

    internal init(view: MainViewInterface, router: MainRouterInterface, interactor: MainInteractorInterface) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }

    deinit {
        print("\(type(of: self)) Deinit")
        LeakDetector.instance.expectDeallocate(object: router as AnyObject)
        LeakDetector.instance.expectDeallocate(object: interactor as AnyObject)
    }

    func viewDidLoad() {
        if let userName = interactor.getLoginedUser() {
            view.showLoading()
            let params = EventParams(username: userName, page: 1)
            interactor.getUserReceivedEvents(params: params)
                .do(onError: { error in
                    self.view.showAlert(title: "Error", message: error.localizedDescription)
                })
                .asDriver(onErrorDriveWith: .just([]))
                .drive(onNext: { result in
                    self.elements = result
                    self.view.hideLoading()
                    self.view.didLoadData()
                }, onCompleted: {
                    self.view.hideLoading()
                })
                .disposed(by: rx.disposeBag)
        }
    }
    
    func didTapLogout() {
        interactor.cleanData()
        router.navigationToLoginScreen()
    }
    
    func navigationToDetailScreen(item: Event) {
        router.navigationToDetailScreen(item: item)
    }

}
