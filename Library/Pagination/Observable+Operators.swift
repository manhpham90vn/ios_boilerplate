//
//  Observable+Operators.swift
//  StoryApp
//
//  Created by Manh Pham on 14/06/2021.
//

import Foundation
import RxSwift
import RxCocoa

public extension ObservableType {

    func asDriverOnErrorJustComplete() -> Driver<Element> {
        return asDriver { _ in
            return Driver.empty()
        }
    }

    func asSignalOnErrorJustComplete() -> Signal<Element> {
        return asSignal { _ in
            return Signal.empty()
        }
    }

}
