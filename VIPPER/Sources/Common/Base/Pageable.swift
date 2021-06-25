//
//  Pageable.swift
//  StoryApp
//
//  Created by Manh Pham on 15/06/2021.
//

import Foundation

typealias PresenterPageable = Pageable & HasHeaderFooterActivityIndicator & HasActivityIndicator & HasDisposeBag
typealias ViewControllerPageable = Pageable & HeaderFooterPageable

protocol Pageable {
    // trigger when pull to refresh and loadmore
    var headerRefreshTrigger: PublishRelay<Void> { get }
    var footerLoadMoreTrigger: PublishRelay<Void> { get }

    // set state for enable loadmore and is empty data
    var isEnableLoadMore: PublishRelay<Bool> { get }
    var isEmptyData: PublishRelay<Bool> { get }
}

protocol HeaderFooterPageable {
    var isHeaderLoading: PublishRelay<Bool> { get }
    var isFooterLoading: PublishRelay<Bool> { get }
}

protocol HasHeaderFooterActivityIndicator {
    var currentPage: Int { get set }
    var headerActivityIndicator: ActivityIndicator { get }
    var footerActivityIndicator: ActivityIndicator { get }
}

extension Pageable where Self: HasDisposeBag & HasHeaderFooterActivityIndicator {
    func bind<T>(paggingable: T) where T: ViewControllerPageable {

        // from viewcontroller to presenter
        paggingable.headerRefreshTrigger ~> headerRefreshTrigger ~ disposeBag
        paggingable.footerLoadMoreTrigger ~> footerLoadMoreTrigger ~ disposeBag

        // from presenter to viewcontroller
        isEnableLoadMore ~> paggingable.isEnableLoadMore ~ disposeBag
        isEmptyData ~> paggingable.isEmptyData ~ disposeBag
        headerActivityIndicator.asSignalOnErrorJustComplete() ~> paggingable.isHeaderLoading ~ disposeBag
        footerActivityIndicator.asSignalOnErrorJustComplete() ~> paggingable.isFooterLoading ~ disposeBag
    }
}
