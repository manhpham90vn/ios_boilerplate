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
    
    private let bag = DisposeBag()
    
    @Inject var connectivityService: ConnectivityService
    
    private let _processing = BehaviorRelay(value: false)
    var processing: Driver<Bool> {
        _processing
            .asDriver()
    }

    private let _succeeded = PublishRelay<R>()
    var succeeded: Driver<R> {
        _succeeded
            .asDriverOnErrorJustComplete()
    }

    private let _failed = PublishRelay<Error>()
    var failed: Driver<Error> {
        _failed
            .asDriverOnErrorJustComplete()
    }

    func buildUseCase(params: P) -> Single<R> { // swiftlint:disable:this unavailable_function
        fatalError("this is abstract")
    }
    
    func execute(params: P) {
        cacheParams = params
        performedIfNeeded(params: params)
    }
    
    func performedIfNeeded(params: P) {
        if _processing.value == true {
            _failed.accept(AppError.actionAlreadyPerforming)
            return
        }
        if !connectivityService.isNetworkConnection {
            _failed.accept(AppError.noInternetConnection)
            return
        }
        _processing.accept(true)
        buildUseCase(params: params)
            .subscribe(onSuccess: { [weak self] result in
                self?._succeeded.accept(result)
                self?._processing.accept(false)
            }, onFailure: { [weak self] error in
                self?._failed.accept(error)
                self?._processing.accept(false)
            })
            .disposed(by: bag)
    }
}
