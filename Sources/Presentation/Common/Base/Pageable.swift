//
//  Pageable.swift
//  StoryApp
//
//  Created by Manh Pham on 15/06/2021.
//

import Foundation
import RxSwift
import RxCocoa
import NSObject_Rx

// view controller
typealias ViewControllerPageable = HasViewControllerPagging
    & HasHeaderFooterTrigger

// presenter
typealias PresenterPageable = HasPresenterPagging
    & HasHeaderFooterTrigger
    & HasDisposeBag
    & HasActivityIndicator

protocol HasHeaderFooterTrigger {
    // trigger when pull to refresh and loadmore
    var headerRefreshTrigger: PublishRelay<Void> { get }
    var footerLoadMoreTrigger: PublishRelay<Void> { get }
}

protocol HasPresenterPagging {
    associatedtype Element
    var currentPage: Int { get set }
    var elements: BehaviorRelay<[Element]> { get }
    var headerActivityIndicator: ActivityIndicator { get }
    var footerActivityIndicator: ActivityIndicator { get }
    var isEnableLoadMore: BehaviorRelay<Bool> { get }
    
    // optional override if you want in presenter
    func bind(paggingable: ViewControllerPageable)
    func bindTrigger(paggingable: ViewControllerPageable)
    func mapEmptyData(paggingable: ViewControllerPageable)
    func mapEnableLoadMore(paggingable: ViewControllerPageable)
    func bindActivityIndicator(paggingable: ViewControllerPageable)
}

protocol HasViewControllerPagging {
    var isEnableLoadMore: PublishRelay<Bool> { get }
    var isEmptyData: PublishRelay<Bool> { get }
    var isHeaderLoading: PublishRelay<Bool> { get }
    var isFooterLoading: PublishRelay<Bool> { get }
}

extension HasPresenterPagging where Self: HasHeaderFooterTrigger & HasDisposeBag & HasActivityIndicator {
    func bind(paggingable: ViewControllerPageable) {

        // viewcontroller trigger to presenter
        bindTrigger(paggingable: paggingable)

        // from presenter to viewcontroller
        mapEmptyData(paggingable: paggingable)
        mapEnableLoadMore(paggingable: paggingable)
        bindActivityIndicator(paggingable: paggingable)
    }

    func bindTrigger(paggingable: ViewControllerPageable) {
        paggingable.headerRefreshTrigger
            .bind(to: headerRefreshTrigger)
            .disposed(by: disposeBag)
        
        paggingable.footerLoadMoreTrigger
            .bind(to: footerLoadMoreTrigger)
            .disposed(by: disposeBag)
    }

    func mapEmptyData(paggingable: ViewControllerPageable) {
        elements
            .map { $0.isEmpty }
            .bind(to: paggingable.isEmptyData)
            .disposed(by: disposeBag)
    }

    func mapEnableLoadMore(paggingable: ViewControllerPageable) {
        isEnableLoadMore
            .bind(to: paggingable.isEnableLoadMore)
            .disposed(by: disposeBag)
    }

    func bindActivityIndicator(paggingable: ViewControllerPageable) {
        headerActivityIndicator
            .asSignalOnErrorJustComplete()
            .emit(to: paggingable.isHeaderLoading)
            .disposed(by: disposeBag)

        footerActivityIndicator
            .asSignalOnErrorJustComplete()
            .emit(to: paggingable.isFooterLoading)
            .disposed(by: disposeBag)
    }
}
