//
//  Pageable.swift
//  StoryApp
//
//  Created by Manh Pham on 15/06/2021.
//

import Foundation

typealias PresenterPageable = Pageable
    & PageablePresenter
    & HasHeaderFooterActivityIndicator
    & HasActivityIndicator
    & HasDisposeBag

typealias ViewControllerPageable = Pageable
    & PageableViewController
    & HeaderFooterPageable

protocol Pageable {
    // trigger when pull to refresh and loadmore
    var headerRefreshTrigger: PublishRelay<Void> { get }
    var footerLoadMoreTrigger: PublishRelay<Void> { get }
}

protocol PageablePresenter {
    var isEnableLoadMore: BehaviorRelay<Bool> { get }
    var isEmptyData: BehaviorRelay<Bool> { get }
    var isShowEmptyViewForFirstTime: Bool { get }
}

protocol PageableViewController {
    var isEnableLoadMore: PublishRelay<Bool> { get }
    var isEmptyData: PublishRelay<Bool> { get }
}

extension PageablePresenter {
    var isShowEmptyViewForFirstTime: Bool {
        false
    }
}

protocol HeaderFooterPageable {
    var isHeaderLoading: PublishRelay<Bool> { get }
    var isFooterLoading: PublishRelay<Bool> { get }
}

protocol HasHeaderFooterActivityIndicator {
    associatedtype Element
    var currentPage: Int { get set }
    var elements: BehaviorRelay<[Element]> { get }
    var headerActivityIndicator: ActivityIndicator { get }
    var footerActivityIndicator: ActivityIndicator { get }
}

extension Pageable where Self: PageablePresenter & HasHeaderFooterActivityIndicator & HasDisposeBag {
    func bind<T>(paggingable: T) where T: ViewControllerPageable {

        // from viewcontroller to presenter
        paggingable.headerRefreshTrigger
            ~> headerRefreshTrigger
            ~ disposeBag
        
        paggingable.footerLoadMoreTrigger
            ~> footerLoadMoreTrigger
            ~ disposeBag

        // from presenter to viewcontroller
        elements
            .map { $0.isEmpty }
            ~> isEmptyData
            ~ disposeBag
        
        isEnableLoadMore
            ~> paggingable.isEnableLoadMore
            ~ disposeBag
        
        isEmptyData
            .skip(isShowEmptyViewForFirstTime ? 0 : 1)
            ~> paggingable.isEmptyData
            ~ disposeBag
        
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
