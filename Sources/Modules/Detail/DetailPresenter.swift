//
//  DetailPresenterInterface.swift
//  VIPPER
//
//  Created by Manh Pham on 06/06/2021.
//

import Foundation
import MPInjector
import NSObject_Rx
import RxSwift
import RxCocoa

protocol DetailPresenterInterface: HasTrigger, HasScreenType {
    var view: DetailViewInterface? { get }
    var router: DetailRouterInterface { get }
    var interactor: DetailInteractorInterface { get }
    var screenType: ScreenType! { get }
    func inject(view: DetailViewInterface, screenType: ScreenType)
    
    var trigger: PublishRelay<Void> { get }
}

final class DetailPresenter: DetailPresenterInterface, HasDisposeBag {

    // dependency
    weak var view: DetailViewInterface?
    @Inject var router: DetailRouterInterface
    @Inject var interactor: DetailInteractorInterface
    
    // local variable
    var screenType: ScreenType!
    
    // input
    let trigger = PublishRelay<Void>()

    func inject(view: DetailViewInterface, screenType: ScreenType) {
        self.view = view
        self.screenType = screenType
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
