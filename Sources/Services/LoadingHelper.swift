//
//  LoadingHelper.swift
//  MyApp
//
//  Created by Manh Pham on 8/29/21.
//

import Foundation
import PKHUD
import RxSwift
import RxCocoa
import NSObject_Rx

/// @mockable
protocol LoadingHelper {
    var isLoading : PublishRelay<Bool> { get }
    func showLoading()
    func hideLoading()
    func perform()
}

final class LoadingHelperImp: LoadingHelper, HasDisposeBag {
    
    let isLoading = PublishRelay<Bool>()
    
    func perform() {
        isLoading.bind(to: PKHUD.rx.isAnimating).disposed(by: disposeBag)
    }
    
    func showLoading() {
        isLoading.accept(true)
    }
    
    func hideLoading() {
        isLoading.accept(false)
    }
    
}
