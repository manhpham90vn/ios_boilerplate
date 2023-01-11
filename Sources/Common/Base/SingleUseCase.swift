//
//  SingleUseCase.swift
//  MyApp
//
//  Created by Manh Pham on 7/30/22.
//

import Foundation
import RxSwift
import RxRelay
import RxCocoa
import MPInjector

class SingleUseCase<P, R>: UseCase {

    var cacheParams: P?

    let trigger = PublishSubject<Void>()
    private let bag = DisposeBag()

    @Inject var connectivityService: ConnectivityService

    private let _processing = BehaviorRelay(value: false)
    var processing: Driver<Bool> {
        _processing
            .asDriver()
    }

    private let _succeeded = PublishSubject<R>()
    var succeeded: Driver<R> {
        _succeeded
            .asDriverOnErrorJustComplete()
    }

    private let _failed = PublishSubject<Error>()
    var failed: Driver<Error> {
        _failed
            .asDriverOnErrorJustComplete()
    }
    
    init() {
        trigger
            .map { [weak self] _ in
                guard let self = self else { return false }
                if self._processing.value {
                    self._failed.onNext(AppError.actionAlreadyPerforming)
                    return false
                }
                if !self.connectivityService.isNetworkConnection {
                    self._failed.onNext(AppError.noInternetConnection)
                    return false
                }
                self._processing.accept(true)
                return true
            }
            .filter { $0 }
            .flatMap { [weak self] _ -> Single<R> in
                guard let self = self, let cacheParams = self.cacheParams else { return .never() }
                return self.buildUseCase(params: cacheParams)
            }
            .asSingle()
            .subscribe(onSuccess: { [weak self] result in
                self?._succeeded.onNext(result)
                self?._processing.accept(false)
            }, onFailure: { [weak self] error in
                self?._failed.onNext(error)
                self?._processing.accept(false)
            })
            .disposed(by: bag)
    }
    
    // do not call this function directly
    func buildUseCase(params: P) -> Single<R> { // swiftlint:disable:this unavailable_function
        fatalError("this is abstract")
    }
    
    final func execute(params: P) {
        cacheParams = params
        trigger.onNext(())
    }
}
