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

private enum LoadingState {
    case isLoading(info: String)
    case done(info: String)
    
    var isLoading: Bool {
        switch self {
        case .isLoading:
            return true
        default:
            return false
        }
    }
    
    var infoData: String {
        switch self {
        case let .isLoading(info):
            return info
        case let .done(info):
            return info
        }
    }
}

extension LoadingState: CustomStringConvertible {
    var description: String {
        switch self {
        case .isLoading:
            return "\(infoData) - \(isLoading)"
        case .done:
            return "\(infoData) - \(isLoading)"
        }
    }
}

extension LoadingState: Equatable {
    static func == (lhs: LoadingState, rhs: LoadingState) -> Bool {
        switch (lhs, rhs) {
        case let (.isLoading(value1), .isLoading(value2)):
            return value1 == value2
        case let (.done(value1), .done(value2)):
            return value1 == value2
        default:
            return false
        }
    }
}

public class ActivityIndicator : SharedSequenceConvertibleType {
    public typealias Element = Bool
    public typealias SharingStrategy = DriverSharingStrategy
    public static let shared = ActivityIndicator()

    private let _lock = NSRecursiveLock()
    private let _relay = BehaviorRelay<[String: LoadingState]>(value: [:])
    private let _loading: SharedSequence<SharingStrategy, Bool>

    public init() {
        _loading = _relay.asDriver()
            .do(onNext: { elements in
                LogInfo(elements)
            })
            .map { $0.first(where: { $0.value.isLoading }) != nil }
            .distinctUntilChanged()
    }

    fileprivate func trackActivityOfObservable<Source: ObservableConvertibleType>(_ source: Source,
                                                                                  isIgnore: Bool,
                                                                                  isShowOneTime: Bool,
                                                                                  functionName: StaticString = #function,
                                                                                  fileName: StaticString = #file,
                                                                                  lineNumber: Int = #line
    ) -> Observable<Source.Element> {
        return Observable.using({ () -> ActivityToken<Source.Element> in
            if isIgnore {
                return ActivityToken(source: source.asObservable(), disposeAction: {})
            }
            let fileName = "\((String(describing: fileName) as NSString).lastPathComponent)"
            let info = "\(fileName) \(functionName) \(lineNumber)"
            let infos = self._relay.value.map { $0.value.infoData }
            if isShowOneTime && infos.contains(info) {
                return ActivityToken(source: source.asObservable(), disposeAction: {})
            }
            let id = UUID().uuidString
            self.increment(id: id, info: info)
            return ActivityToken(source: source.asObservable()) {
                self.decrement(id: id, info: info)
            }
        }) { t in
            return t.asObservable()
        }
    }
    
    private func increment(id: String, info: String) {
        _lock.lock()
        var elements = _relay.value
        elements[id] = .isLoading(info: info)
        _relay.accept(elements)
        _lock.unlock()
    }

    private func decrement(id: String, info: String) {
        _lock.lock()
        var elements = _relay.value
        elements[id] = .done(info: info)
        _relay.accept(elements)
        _lock.unlock()
    }

    public func asSharedSequence() -> SharedSequence<SharingStrategy, Element> {
        _loading
    }

    public func asSignalOnErrorJustComplete() -> Signal<Element> {
        _loading.asSignal { _ in
            Signal.empty()
        }
    }
    
    public func forceStopAll() {
        _lock.lock()
        _relay.accept([:])
        _lock.unlock()
    }
}

extension ObservableConvertibleType {
    public func trackActivity(_ activityIndicator: ActivityIndicator,
                              isIgnore: Bool = false,
                              isShowOneTime: Bool = false,
                              functionName: StaticString = #function,
                              fileName: StaticString = #file,
                              lineNumber: Int = #line) -> Observable<Element> {
        activityIndicator.trackActivityOfObservable(self,
                                                    isIgnore: isIgnore,
                                                    isShowOneTime: isShowOneTime,
                                                    functionName: functionName,
                                                    fileName: fileName,
                                                    lineNumber: lineNumber)
    }
}
