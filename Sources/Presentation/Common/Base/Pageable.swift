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
            ~> headerRefreshTrigger
            ~ disposeBag
        
        paggingable.footerLoadMoreTrigger
            ~> footerLoadMoreTrigger
            ~ disposeBag
    }

    func mapEmptyData(paggingable: ViewControllerPageable) {
        elements
            .map { $0.isEmpty }
            ~> paggingable.isEmptyData
            ~ disposeBag
    }

    func mapEnableLoadMore(paggingable: ViewControllerPageable) {
        isEnableLoadMore
            ~> paggingable.isEnableLoadMore
            ~ disposeBag
    }

    func bindActivityIndicator(paggingable: ViewControllerPageable) {
        headerActivityIndicator
            .asSignalOnErrorJustComplete()
            ~> paggingable.isHeaderLoading
            ~ disposeBag

        footerActivityIndicator
            .asSignalOnErrorJustComplete()
            ~> paggingable.isFooterLoading
            ~ disposeBag
    }
}
