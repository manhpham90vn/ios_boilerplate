//
//  MainPresenter.swift
//  VIPPER
//
//  Created by Manh Pham on 3/5/21.
//

import UIKit
import RxSwift
import RxCocoa
import Resolver

protocol MainPresenterInterface {
    
    var view: MainViewInterface? { get }
    var router: MainRouterInterface { get }
    var interactor: MainInteractorInterface { get }
    func inject(view: MainViewInterface)
    
    func didTapLogout()
    func navigationToDetailScreen(item: Paging)
    func reload()
}

final class MainPresenter: MainPresenterInterface, PresenterPageable {

    weak var view: MainViewInterface?
    @Injected var router: MainRouterInterface
    @Injected var interactor: MainInteractorInterface

    let elements = BehaviorRelay<[Paging]>(value: [])
    let activityIndicator = ActivityIndicator.shared
    let trigger = PublishRelay<Void>()
    let headerRefreshTrigger = PublishRelay<Void>()
    let footerLoadMoreTrigger = PublishRelay<Void>()
    let isEnableLoadMore = BehaviorRelay<Bool>(value: true)
    let isEmptyData = BehaviorRelay<Bool>(value: true)
    let headerActivityIndicator = ActivityIndicator()
    let footerActivityIndicator = ActivityIndicator()
    var currentPage = 1
    let triggerGetUserInfo = PublishRelay<Void>()

    init() {
        trigger
            .flatMapLatest { [weak self] () -> Driver<[Paging]> in
                guard let self = self else { return .never() }
                self.currentPage = 1
                self.isEnableLoadMore.accept(true)
                return self.interactor
                    .getDataPaging(page: self.currentPage)
                    .trackActivity(self.activityIndicator)
                    .debugToFile()
                    .asDriver(onErrorJustReturn: [])
            }
            .do(onNext: { [weak self] _ in
                self?.triggerGetUserInfo.accept(())
            })
            .bind(to: elements)
            .disposed(by: disposeBag)

        Observable.merge(triggerGetUserInfo.asObservable())
            .flatMapLatest { [weak self] _ -> Driver<User> in
                guard let self = self else { return .never() }
                return self.interactor.getUserInfo()
                    .trackActivity(self.activityIndicator)
                    .asDriverOnErrorJustComplete()
            }
            .asDriverOnErrorJustComplete()
            .drive()
            .disposed(by: disposeBag)
        
        headerRefreshTrigger
            .flatMapLatest { [weak self] () -> Driver<[Paging]> in
                guard let self = self else { return .never() }
                self.currentPage = 1
                self.isEnableLoadMore.accept(true)
                return self.interactor
                    .getDataPaging(page: self.currentPage)
                    .trackActivity(self.headerActivityIndicator)
                    .asDriver(onErrorJustReturn: [])
            }
            .bind(to: elements)
            .disposed(by: disposeBag)

        footerLoadMoreTrigger
            .flatMapLatest { [weak self] () -> Driver<[Paging]> in
                guard let self = self else { return .never() }
                self.currentPage += 1
                return self.interactor
                    .getDataPaging(page: self.currentPage)
                    .trackActivity(self.footerActivityIndicator)
                    .asDriver(onErrorJustReturn: [])
            }
            .asDriver(onErrorJustReturn: [])
            .drive(onNext: { [weak self] result in
                guard let self = self else { return }
                var current = self.elements.value
                current += result
                if current.count > 1000 {
                    self.isEnableLoadMore.accept(false)
                } else {
                    self.isEnableLoadMore.accept(true)
                }
                self.elements.accept(current)
            })
            .disposed(by: disposeBag)
    }

    func inject(view: MainViewInterface) {
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
    
    func didTapLogout() {
        interactor.cleanData()
        router.navigationToLoginScreen()
    }
    
    func navigationToDetailScreen(item: Paging) {
        router.navigationToDetailScreen(item: item)
    }
    
    func reload() {
        trigger.accept(())
    }

}
