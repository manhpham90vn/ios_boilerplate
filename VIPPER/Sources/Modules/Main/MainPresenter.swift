//
//  MainPresenter.swift
//  VIPPER
//
//  Created by Manh Pham on 3/5/21.
//

import UIKit

protocol MainPresenterInterface {
    
    var view: MainViewInterface! { get }
    var router: MainRouterInterface { get }
    var interactor: MainInteractorInterface { get }

    func viewDidLoad(view: MainViewInterface)
    
    func didTapLogout()
    func navigationToDetailScreen(item: Event)
    func reload()
}

final class MainPresenter: MainPresenterInterface, PresenterPageable {

    unowned var view: MainViewInterface!
    @Injected var router: MainRouterInterface
    @Injected var interactor: MainInteractorInterface

    let elements = BehaviorRelay<[Event]>(value: [])
    let activityIndicator = ActivityIndicator.shared
    let trigger = PublishRelay<Void>()
    let headerRefreshTrigger = PublishRelay<Void>()
    let footerLoadMoreTrigger = PublishRelay<Void>()
    let isEnableLoadMore = BehaviorRelay<Bool>(value: true)
    let isEmptyData = BehaviorRelay<Bool>(value: true)
    let headerActivityIndicator = ActivityIndicator()
    let footerActivityIndicator = ActivityIndicator()
    var currentPage = 1

    init() {
        trigger
            .flatMapLatest { [weak self] () -> Driver<[Event]> in
                guard let self = self else { return .never() }
                guard let userName = self.interactor.getLoginedUser() else { return .never() }
                self.currentPage = 1
                self.isEnableLoadMore.accept(true)
                let params = EventParams(username: userName, page: self.currentPage)
                return self.interactor
                    .getUserReceivedEvents(params: params)
                    .trackActivity(self.activityIndicator)
                    .debugToFile()
                    .asDriverOnErrorJustComplete()
            }
            ~> elements
            ~ disposeBag
        
        headerRefreshTrigger
            .flatMapLatest { [weak self] () -> Driver<[Event]> in
                guard let self = self else { return .never() }
                guard let userName = self.interactor.getLoginedUser() else { return .never() }
                self.currentPage = 1
                self.isEnableLoadMore.accept(true)
                let params = EventParams(username: userName, page: self.currentPage)
                return self.interactor
                    .getUserReceivedEvents(params: params)
                    .trackActivity(self.headerActivityIndicator)
                    .asDriverOnErrorJustComplete()
            }
            ~> elements
            ~ disposeBag

        footerLoadMoreTrigger
            .flatMapLatest { [weak self] () -> Driver<[Event]> in
                guard let self = self else { return .never() }
                guard let userName = self.interactor.getLoginedUser() else { return .never() }
                self.currentPage += 1
                let params = EventParams(username: userName, page: self.currentPage)
                return self.interactor
                    .getUserReceivedEvents(params: params)
                    .trackActivity(self.footerActivityIndicator)
                    .asDriverOnErrorJustComplete()
            }
            .asDriverOnErrorJustComplete()
            .drive(onNext: { [weak self] result in
                guard let self = self else { return }
                var current = self.elements.value
                current += result
                if current.count > 100 {
                    self.isEnableLoadMore.accept(false)
                } else {
                    self.isEnableLoadMore.accept(true)
                }
                self.elements.accept(current)
            })
            ~ disposeBag
    }

    func viewDidLoad(view: MainViewInterface) {
        self.view = view
    }
    
    deinit {
        if Configs.shared.loggingDeinitEnabled {
            LogInfo("\(Swift.type(of: self)) Deinit")
        }
        LeakDetector.instance.expectDeallocate(object: router as AnyObject)
        LeakDetector.instance.expectDeallocate(object: interactor as AnyObject)
    }
    
    func didTapLogout() {
        interactor.cleanData()
        router.navigationToLoginScreen()
    }
    
    func navigationToDetailScreen(item: Event) {
        guard let view = view as? UIViewController else { return }
        router.navigationToDetailScreen(viewController: view, item: item)
    }
    
    func reload() {
        trigger.accept(())
    }

}
