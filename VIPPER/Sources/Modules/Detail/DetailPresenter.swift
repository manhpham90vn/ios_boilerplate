//
//  DetailPresenterInterface.swift
//  VIPPER
//
//  Created by Manh Pham on 06/06/2021.
//

import Foundation

protocol DetailPresenterInterface: Presenter {
    var view: DetailViewInterface { get set }
    var router: DetailRouterInterface { get set }
    var interactor: DetailInteractorInterface { get set }
}

final class DetailPresenter: DetailPresenterInterface, HasActivityIndicator, HasDisposeBag {

    unowned var view: DetailViewInterface
    var router: DetailRouterInterface
    var interactor: DetailInteractorInterface

    var activityIndicator = ActivityIndicator()
    var trigger = PublishRelay<Void>()

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
