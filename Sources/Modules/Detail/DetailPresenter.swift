//
//  DetailPresenterInterface.swift
//  VIPPER
//
//  Created by Manh Pham on 06/06/2021.
//

import Foundation

protocol DetailPresenterInterface {
    var view: DetailViewInterface? { get }
    var router: DetailRouterInterface { get }
    var interactor: DetailInteractorInterface { get }
    func inject(view: DetailViewInterface)
}

final class DetailPresenter: DetailPresenterInterface, HasActivityIndicator, HasDisposeBag {

    weak var view: DetailViewInterface?
    @Injected var router: DetailRouterInterface
    @Injected var interactor: DetailInteractorInterface

    let activityIndicator = ActivityIndicator.shared
    let trigger = PublishRelay<Void>()

    func inject(view: DetailViewInterface) {
        self.view = view
        self.router.inject(view: view)
    }
    
    deinit {
        if Configs.shared.loggingDeinitEnabled {
            LogInfo("\(Swift.type(of: self)) Deinit")
        }
        LeakDetector.instance.expectDeallocate(object: router as AnyObject)
        LeakDetector.instance.expectDeallocate(object: interactor as AnyObject)
    }

}
