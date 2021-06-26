//
//  DetailPresenterInterface.swift
//  VIPPER
//
//  Created by Manh Pham on 06/06/2021.
//

import Foundation

protocol DetailPresenterInterface: Presenter {
    var view: DetailViewInterface { get }
    var router: DetailRouterInterface { get }
    var interactor: DetailInteractorInterface { get }
}

final class DetailPresenter: DetailPresenterInterface, HasActivityIndicator, HasDisposeBag {

    unowned let view: DetailViewInterface
    let router: DetailRouterInterface
    let interactor: DetailInteractorInterface

    let activityIndicator = ActivityIndicator()
    let trigger = PublishRelay<Void>()

    init(view: DetailViewInterface,
         router: DetailRouterInterface,
         interactor: DetailInteractorInterface) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }

    deinit {
        LogInfo("\(type(of: self)) Deinit")
        LeakDetector.instance.expectDeallocate(object: router as AnyObject)
        LeakDetector.instance.expectDeallocate(object: interactor as AnyObject)
    }

}
