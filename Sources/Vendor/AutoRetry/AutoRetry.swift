// The MIT License (MIT)
//
// Copyright (c) 2017 Alexander Grebenyuk (github.com/kean).

import Foundation
import RxSwift
import RxCocoa
import Reachability
import RxReachability

extension PrimitiveSequence {
    /// Retries the source observable sequence on error using a provided retry
    /// strategy.
    /// - parameter maxAttemptCount: Maximum number of times to repeat the
    /// sequence. `5` by default.
    /// - parameter didBecomeReachable: Trigger which is fired when network
    /// connection becomes reachable.
    /// - parameter shouldRetry: Always retruns `true` by default.
    func autoRetry(_ maxAttemptCount: Int = 3,
               delay: DelayOptions,
               didBecomeReachable: Observable<Void> = Reachability.rx.isConnected,
               shouldRetry: @escaping (Error) -> Bool = { _ in true }) -> PrimitiveSequence<Trait, Element> {
        return retry { (errors: Observable<Error>) in
            return errors.enumerated().flatMap { attempt, error -> Observable<Void> in
                let attemptCount = attempt + 1
                
                guard maxAttemptCount > attemptCount, shouldRetry(error) else {
                    return .error(error)
                }

                let delay = delay.make(attemptCount)
                
                let timer = Observable<Int>.timer(
                    delay,
                    scheduler: MainScheduler.instance
                )
                .map { _ in } // cast to Observable<Void>

                return Observable.merge(timer, didBecomeReachable.asObservable())
            }
        }
    }
}

enum DelayOptions {
    case immediate
    case constant(time: Double)
    case exponential(initial: Double, multiplier: Double, maxDelay: Double)
    case custom(closure: (Int) -> Double)
}

extension DelayOptions {
    func make(_ attempt: Int) -> RxTimeInterval {
        var interval: Double {
            switch self {
            case .immediate:
                return 0.0
            case .constant(let time):
                return time
            case let .exponential(initial, multiplier, maxDelay):
                // if it's first attempt, simply use initial delay, otherwise calculate delay
                let delay = attempt == 1 ? initial : initial * pow(multiplier, Double(attempt - 1))
                return min(maxDelay, delay)
            case .custom(let closure):
                return closure(attempt)
            }
        }
        return .milliseconds(Int(interval * 1000))
    }
}
