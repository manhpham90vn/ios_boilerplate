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

final class LoadingHelper: HasDisposeBag {
    
    static let shared = LoadingHelper()

    private let isLoading = PublishRelay<Bool>()
    init() {}
    
    func perform() {
        ActivityIndicator.shared.asSignalOnErrorJustComplete() ~> isLoading ~ disposeBag
        isLoading ~> PKHUD.rx.isAnimating ~ disposeBag
    }
    
    func showLoading() {
        isLoading.accept(true)
    }
    
    func hideLoading() {
        isLoading.accept(false)
    }
    
}
