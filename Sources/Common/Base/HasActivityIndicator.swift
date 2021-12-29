//
//  HasActivityIndicator.swift
//  StoryApp
//
//  Created by Manh Pham on 14/06/2021.
//

import Foundation

protocol HasActivityIndicator {
    var trigger: PublishRelay<Void> { get }
    var activityIndicator: ActivityIndicator { get }
}
