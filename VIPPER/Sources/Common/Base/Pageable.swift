//
//  Pageable.swift
//  StoryApp
//
//  Created by Manh Pham on 15/06/2021.
//

import Foundation

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
}

protocol HasViewControllerPagging {
    var isEnableLoadMore: PublishRelay<Bool> { get }
    var isEmptyData: PublishRelay<Bool> { get }
    var isHeaderLoading: PublishRelay<Bool> { get }
    var isFooterLoading: PublishRelay<Bool> { get }
}

extension HasPresenterPagging where Self: HasHeaderFooterTrigger & HasDisposeBag & HasActivityIndicator {
    func bind<ViewController>(paggingable: ViewController) where ViewController: ViewControllerPageable {

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
            ~> paggingable.isEmptyData
            ~ disposeBag
        
        isEnableLoadMore
            ~> paggingable.isEnableLoadMore
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
