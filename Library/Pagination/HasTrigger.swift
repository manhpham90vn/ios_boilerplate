//
//  HasTrigger.swift
//  StoryApp
//
//  Created by Manh Pham on 14/06/2021.
//

import Foundation
import RxSwift
import RxCocoa

public protocol HasTrigger {
    var trigger: PublishRelay<Void> { get }
}
