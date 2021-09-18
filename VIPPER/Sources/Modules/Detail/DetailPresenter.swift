//
//  DetailPresenterInterface.swift
//  VIPPER
//
//  Created by Manh Pham on 06/06/2021.
//

import Foundation

protocol DetailPresenterInterface {
    var view: DetailViewInterface! { get }
    var router: DetailRouterInterface { get }
    var interactor: DetailInteractorInterface { get }
    
    func viewDidLoad(view: DetailViewInterface)
}

final class DetailPresenter: DetailPresenterInterface, HasActivityIndicator, HasDisposeBag {

    unowned var view: DetailViewInterface!
    @Injected var router: DetailRouterInterface
    @Injected var interactor: DetailInteractorInterface

    let activityIndicator = ActivityIndicator.shared
    let trigger = PublishRelay<Void>()

    func viewDidLoad(view: DetailViewInterface) {
        self.view = view
    }
    
    deinit {
        if Configs.shared.loggingDeinitEnabled {
            LogInfo("\(Swift.type(of: self)) Deinit")
        }
        LeakDetector.instance.expectDeallocate(object: router as AnyObject)
        LeakDetector.instance.expectDeallocate(object: interactor as AnyObject)
    }

}
