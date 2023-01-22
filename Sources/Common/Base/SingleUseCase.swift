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
    
    // input
    let trigger = PublishRelay<P>()
    var cacheParams: P?
    
    // output
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
    
    // private
    private let disposeBag = DisposeBag()
    
    // service
    @Inject var connectivityService: ConnectivityService
    
    init() {
        trigger
            .withUnretained(self)
            .map { obj, data -> (Bool, P) in
                // cache params if nil
                if obj.cacheParams == nil {
                    obj.cacheParams = data
                }
                
                // check if usecase is running
                if obj._processing.value == true {
                    obj._failed.accept(AppError.actionAlreadyPerforming)
                    return (false, data)
                }
                
                // check if usecase not have internet
                if !obj.connectivityService.isNetworkConnection {
                    obj._failed.accept(AppError.noInternetConnection)
                    return (false, data)
                }
                
                // set processing
                obj._processing.accept(true)
                return (true, data)
            }
            .withUnretained(self)
            .flatMap { obj, data -> Observable<Event<R>> in
                if data.0 {
                    return obj.buildUseCase(params: data.1)
                        .asObservable()
                        .materialize()
                } else {
                    obj._processing.accept(false)
                    return .never()
                }
            }
            .withUnretained(self)
            .subscribe(onNext: { obj, result in
                obj._processing.accept(false)
                switch result {
                case let .next(element):
                    obj._succeeded.accept(element)
                case let .error(error):
                    obj._failed.accept(error)
                case .completed:
                    break
                }
            })
            .disposed(by: disposeBag)
    }
    
    func buildUseCase(params: P) -> Single<R> { // swiftlint:disable:this unavailable_function
        fatalError("this is abstract")
    }
    
    func execute(params: P) {
        cacheParams = params
        trigger.accept(params)
    }
}
