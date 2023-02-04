//
//  Recorder.swift
//  MyProductTests
//
//  Created by manh on 02/02/2023.
//

import Foundation
import RxSwift
import RxCocoa

class Recorder<T> {
    var items = [T]()
    let bag = DisposeBag()
    
    func onNext(arraySubject: PublishSubject<[T]>) {
        arraySubject
            .subscribe(onNext: { value in
                self.items = value
            })
            .disposed(by: bag)
    }

    func onNext(valueSubject: PublishSubject<T>) {
        valueSubject
            .subscribe(onNext: { value in
                self.items.append(value)
            })
            .disposed(by: bag)
    }
    
    func onNext(arraySubject: Driver<[T]>) {
        arraySubject
            .drive(onNext: { value in
                self.items = value
            })
            .disposed(by: bag)
    }

    func onNext(valueSubject: Driver<T>) {
        valueSubject
            .drive(onNext: { value in
                self.items.append(value)
            })
            .disposed(by: bag)
    }
}
