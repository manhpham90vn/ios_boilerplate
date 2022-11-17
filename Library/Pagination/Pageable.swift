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
public typealias ViewControllerPageable = HasViewControllerPagging
    & HasHeaderFooterTrigger

// presenter
public typealias PresenterPageable = HasPresenterPagging
    & HasHeaderFooterTrigger
    & HasDisposeBag
    & HasTrigger

public protocol HasHeaderFooterTrigger {
    // trigger when pull to refresh and loadmore
    var headerRefreshTrigger: PublishRelay<Void> { get }
    var footerLoadMoreTrigger: PublishRelay<Void> { get }
}

public protocol HasPresenterPagging {
    associatedtype Element
    var currentPage: Int { get set }
    var elements: BehaviorRelay<[Element]> { get }
    var isHeaderLoading: PublishSubject<Bool> { get }
    var isFooterLoading: PublishSubject<Bool> { get }
    var isEnableLoadMore: PublishSubject<Bool> { get }
    
    // optional override if you want in presenter
    func bind(paggingable: ViewControllerPageable)
    func bindTrigger(paggingable: ViewControllerPageable)
    func mapEmptyData(paggingable: ViewControllerPageable)
    func mapEnableLoadMore(paggingable: ViewControllerPageable)
    func bindActivityIndicator(paggingable: ViewControllerPageable)
}

public protocol HasViewControllerPagging {
    var isEnableLoadMore: PublishRelay<Bool> { get }
    var isEmptyData: PublishRelay<Bool> { get }
    var isHeaderLoading: PublishRelay<Bool> { get }
    var isFooterLoading: PublishRelay<Bool> { get }
}

public extension HasPresenterPagging where Self: HasHeaderFooterTrigger & HasDisposeBag & HasTrigger {
    public func bind(paggingable: ViewControllerPageable) {

        // viewcontroller trigger to presenter
        bindTrigger(paggingable: paggingable)

        // from presenter to viewcontroller
        mapEmptyData(paggingable: paggingable)
        mapEnableLoadMore(paggingable: paggingable)
        bindActivityIndicator(paggingable: paggingable)
    }

    public func bindTrigger(paggingable: ViewControllerPageable) {
        paggingable.headerRefreshTrigger
            .bind(to: headerRefreshTrigger)
            .disposed(by: disposeBag)
        
        paggingable.footerLoadMoreTrigger
            .bind(to: footerLoadMoreTrigger)
            .disposed(by: disposeBag)
    }

    public func mapEmptyData(paggingable: ViewControllerPageable) {
        elements
            .map { $0.isEmpty }
            .bind(to: paggingable.isEmptyData)
            .disposed(by: disposeBag)
    }

    public func mapEnableLoadMore(paggingable: ViewControllerPageable) {
        isEnableLoadMore
            .bind(to: paggingable.isEnableLoadMore)
            .disposed(by: disposeBag)
    }

    public func bindActivityIndicator(paggingable: ViewControllerPageable) {
        isHeaderLoading
            .asSignalOnErrorJustComplete()
            .emit(to: paggingable.isHeaderLoading)
            .disposed(by: disposeBag)

        isFooterLoading
            .asSignalOnErrorJustComplete()
            .emit(to: paggingable.isFooterLoading)
            .disposed(by: disposeBag)
    }
}
