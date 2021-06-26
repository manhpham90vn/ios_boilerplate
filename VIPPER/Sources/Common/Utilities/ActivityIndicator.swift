//
//  ActivityIndicator.swift
//  RxExample
//
//  Created by Krunoslav Zaher on 10/18/15.
//  Copyright © 2015 Krunoslav Zaher. All rights reserved.
//

import RxSwift
import RxCocoa

private struct ActivityToken<E> : ObservableConvertibleType, Disposable {
    private let _source: Observable<E>
    private let _dispose: Cancelable

    init(source: Observable<E>, disposeAction: @escaping () -> Void) {
        _source = source
        _dispose = Disposables.create(with: disposeAction)
    }

    func dispose() {
        _dispose.dispose()
    }

    func asObservable() -> Observable<E> {
        _source
    }
}

/**
Enables monitoring of sequence computation.

If there is at least one sequence computation in progress, `true` will be sent.
When all activities complete `false` will be sent.
*/
public class ActivityIndicator : SharedSequenceConvertibleType {
    public typealias Element = Bool
    public typealias SharingStrategy = DriverSharingStrategy

    private let _lock = NSRecursiveLock()
    private let _relay = BehaviorRelay(value: 0)
    private let _loading: SharedSequence<SharingStrategy, Bool>
    @Atomic private var isShowedLoading = false

    public init() {
        _loading = _relay.asDriver()
            .map { $0 > 0 }
            .distinctUntilChanged()
    }

    fileprivate func trackActivityOfObservable<Source: ObservableConvertibleType>(_ source: Source, ignore: Bool) -> Observable<Source.Element> {
        return Observable.using({ () -> ActivityToken<Source.Element> in
            if !ignore {
                self.increment()
            }
            let disposeAction = ignore ? {} : self.decrement
            return ActivityToken(source: source.asObservable(), disposeAction: disposeAction)
        }) { t in
            return t.asObservable()
        }
    }

    fileprivate func trackActivityOfObservableOnlyOnce<Source: ObservableConvertibleType>(_ source: Source, ignore: Bool) -> Observable<Source.Element> {
        return Observable.using({ () -> ActivityToken<Source.Element> in
            if !self.isShowedLoading && !ignore {
                self.increment()
            }
            let disposeAction = (self.isShowedLoading && ignore) ? {} : self.decrement
            self.isShowedLoading = true
            return ActivityToken(source: source.asObservable(), disposeAction: disposeAction)
        }, observableFactory: { value in
            return value.asObservable()
        })
    }
    
    private func increment() {
        _lock.lock()
        _relay.accept(_relay.value + 1)
        _lock.unlock()
    }

    private func decrement() {
        _lock.lock()
        _relay.accept(_relay.value - 1)
        _lock.unlock()
    }

    public func asSharedSequence() -> SharedSequence<SharingStrategy, Element> {
        _loading
    }

    func asSignalOnErrorJustComplete() -> Signal<Element> {
        _loading.asSignal { _ in
            Signal.empty()
        }
    }
}

extension ObservableConvertibleType {
    public func trackActivity(_ activityIndicator: ActivityIndicator, ignore: Bool = false) -> Observable<Element> {
        activityIndicator.trackActivityOfObservable(self, ignore: ignore)
    }
    
    public func trackActivityOnlyOnce(_ activityIndicator: ActivityIndicator, ignore: Bool = false) -> Observable<Element> {
        return activityIndicator.trackActivityOfObservableOnlyOnce(self, ignore: ignore)
    }
}
