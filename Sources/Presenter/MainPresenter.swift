//
//  MainPresenter.swift
//  VIPPER
//
//  Created by Manh Pham on 3/5/21.
//

import UIKit
import RxSwift
import RxCocoa
import MPInjector

protocol MainPresenterInterface: HasTrigger, HasScreenType {
    
    var view: MainViewInterface? { get }
    var router: MainRouterInterface { get }
    var interactor: MainInteractorInterface { get }
    var screenType: ScreenType! { get }
    func inject(view: MainViewInterface, screenType: ScreenType)
    
    func didTapLogout()
    func navigationToDetailScreen(user: PagingUserResponse)
}

final class MainPresenter: MainPresenterInterface, PresenterPageable {

    // dependency
    weak var view: MainViewInterface?
    @Inject var router: MainRouterInterface
    @Inject var interactor: MainInteractorInterface
    @Inject var loading: LoadingHelper
    @Inject var errorHandler: ApiErrorHandler

    // input
    let trigger = PublishRelay<Void>()
    let headerRefreshTrigger = PublishRelay<Void>()
    let footerLoadMoreTrigger = PublishRelay<Void>()
    let isEnableLoadMore = PublishSubject<Bool>()
    let isHeaderLoading = PublishSubject<Bool>()
    let isFooterLoading = PublishSubject<Bool>()
    let triggerGetUserInfo = PublishRelay<Void>()
    var currentPage = 1
    
    // local variable
    var screenType: ScreenType!
    
    // output
    let elements = BehaviorRelay<[PagingUserResponse]>(value: [])
    
    init() {
        Driver.combineLatest(
            interactor.getEventUseCaseInterface.processing,
            interactor.getUserInfoUseCase.processing
        ) {
            $0 || $1
        }
        .distinctUntilChanged()
        .drive(onNext: { [weak self] isLoading in
            self?.loading.isLoading.accept(isLoading)
        })
        .disposed(by: disposeBag)
        
        Driver.merge(interactor.getEventUseCaseInterface.failed,
                     interactor.getUserInfoUseCase.failed)
            .throttle(.seconds(1), latest: false)
            .drive(onNext: { [weak self] error in
                guard let self = self else { return }
                self.isEnableLoadMore.onNext(true)
                self.isHeaderLoading.onNext(false)
                self.isFooterLoading.onNext(false)
                self.errorHandler.handle(error: error, screenType: self.screenType, callback: nil)
            })
            .disposed(by: disposeBag)
        
        Observable.merge(trigger.asObservable(), headerRefreshTrigger.asObservable())
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.currentPage = 1
                self.isEnableLoadMore.onNext(true)
                self.interactor.getEventUseCaseInterface.execute(params: .init(page: self.currentPage,
                                                                               sort: .ascending,
                                                                               type: .refreshOrFirstLoad))
                self.interactor.getUserInfoUseCase.execute(params: ())
            })
            .disposed(by: disposeBag)
        
        footerLoadMoreTrigger
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.currentPage += 1
                self.interactor.getEventUseCaseInterface.execute(params: .init(page: self.currentPage,
                                                                               sort: .ascending,
                                                                               type: .loadMore))
            })
            .disposed(by: disposeBag)
        
        interactor
            .getUserInfoUseCase
            .succeeded
            .drive(onNext: { result in
                LogInfo("\(result.email ?? "")")
            })
            .disposed(by: disposeBag)
        
        interactor
            .getEventUseCaseInterface
            .succeeded
            .drive(onNext: { [weak self] result in
                guard let self = self else { return }
                switch result.1 {
                case .refreshOrFirstLoad:
                    // update element
                    self.elements.accept(result.0)
                    // update animation
                    self.isHeaderLoading.onNext(false)
                case .loadMore:
                    // config isEnable load more
                    if result.0.isEmpty {
                        self.isEnableLoadMore.onNext(false)
                    } else {
                        self.isEnableLoadMore.onNext(true)
                    }
                    // update elements
                    var current = self.elements.value
                    current += result.0
                    self.elements.accept(current)
                    // update loading animation
                    self.isFooterLoading.onNext(false)
                }
            })
            .disposed(by: disposeBag)
    }

    func inject(view: MainViewInterface, screenType: ScreenType) {
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
    
    func didTapLogout() {
        interactor.cleanUserInfoUseCaseInterface.execute(params: ())
        router.navigationToLoginScreen()
    }
    
    func navigationToDetailScreen(user: PagingUserResponse) {
        router.navigationToDetailScreen(user: user)
    }
}
