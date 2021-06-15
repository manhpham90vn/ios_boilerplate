//
//  Paggingable.swift
//  StoryApp
//
//  Created by Manh Pham on 15/06/2021.
//

import Foundation

protocol Paggingable {
    // trigger when pull to refresh and loadmore
    var headerRefreshTrigger: PublishRelay<Void> { get }
    var footerLoadMoreTrigger: PublishRelay<Void> { get }

    // set state for enable loadmore and is empty data
    var isEnableLoadMore: PublishRelay<Bool> { get }
    var isEmptyData: PublishRelay<Bool> { get }
}

protocol HeaderFooterPaggingable {
    var isHeaderLoading: PublishRelay<Bool> { get }
    var isFooterLoading: PublishRelay<Bool> { get }
}

protocol HeaderFooterActivityIndicator {
    var headerActivityIndicator: ActivityIndicator { get }
    var footerActivityIndicator: ActivityIndicator { get }
}

extension Paggingable where Self: HasDisposeBag & HeaderFooterActivityIndicator {
    func bind<T>(paggingable: T) where T: Paggingable & HeaderFooterPaggingable {

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
