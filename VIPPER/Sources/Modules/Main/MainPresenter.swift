//
//  MainPresenter.swift
//  VIPPER
//
//  Created by Manh Pham on 3/5/21.
//

import UIKit

protocol MainPresenterInterface {
    var view: MainViewInterface { get set }
    var router: MainRouterInterface { get set }
    var interactor: MainInteractorInterface { get set }
    
    var elements: [Event] { get set }

    func viewDidLoad()
    func didTapLogout()
    func navigationToDetailScreen(item: Event)
}

final class MainPresenter: BasePresenter, MainPresenterInterface {

    unowned var view: MainViewInterface
    var router: MainRouterInterface
    var interactor: MainInteractorInterface

    var elements: [Event] = []

    internal init(view: MainViewInterface, router: MainRouterInterface, interactor: MainInteractorInterface) {
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

    func viewDidLoad() {
        if let userName = interactor.getLoginedUser() {
            view.showLoading(isLoading: true)
            let params = EventParams(username: userName, page: 1)
            interactor.getUserReceivedEvents(params: params)
                .trackActivity(activityIndicator)
                .asDriver(onErrorDriveWith: .just([]))
                .drive(onNext: { result in
                    self.elements = result
                    self.view.didLoadData()
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
