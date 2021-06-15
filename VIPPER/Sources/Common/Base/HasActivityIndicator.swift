//
//  HasActivityIndicator.swift
//  StoryApp
//
//  Created by Manh Pham on 14/06/2021.
//

import Foundation

protocol HasActivityIndicator {
    var activityIndicator: ActivityIndicator { get set }
}

extension HasActivityIndicator where Self: HasDisposeBag {
    func bind(isLoading: PublishRelay<Bool>) {
        activityIndicator.asSignalOnErrorJustComplete() ~> isLoading ~ disposeBag
    }
}
