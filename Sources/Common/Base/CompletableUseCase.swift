//
//  CompletableUseCase.swift
//  MyApp
//
//  Created by Manh Pham on 24/11/2022.
//

import Foundation
import RxSwift
import RxRelay
import RxCocoa
import MPInjector

class CompletableUseCase<P>: UseCase {

    var cacheParams: P?

    let trigger = PublishSubject<Void>()
    private let bag = DisposeBag()

    @Inject var connectivityService: ConnectivityService

    private let _processing = BehaviorRelay(value: false)
    var processing: Driver<Bool> {
        _processing
            .asDriver()
    }

    private let _succeeded = PublishSubject<Void>()
    var succeeded: Driver<Void> {
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
            .flatMap { [weak self] _ -> Completable in
                guard let self = self, let cacheParams = self.cacheParams else { return .never() }
                return self.buildUseCase(params: cacheParams)
            }
            .subscribe(onError: { [weak self] error in
                self?._failed.onNext(error)
                self?._processing.accept(false)
            }, onCompleted: { [weak self] in
                self?._succeeded.onNext(())
                self?._processing.accept(false)
            })
            .disposed(by: bag)
    }

    func buildUseCase(params: P) -> Completable { // swiftlint:disable:this unavailable_function
        fatalError("this is abstract")
    }

    final func execute(params: P) {
        cacheParams = params
        trigger.onNext(())
    }
}
