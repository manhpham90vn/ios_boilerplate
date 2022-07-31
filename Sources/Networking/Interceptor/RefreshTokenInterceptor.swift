//
//  RefreshTokenInterceptor.swift
//  AlamofireFeatureTest
//
//  Created by Manh Pham on 6/19/22.
//

import Foundation
import Alamofire
import Resolver
import UIKit
import RxSwift

final class RefreshTokenInterceptor: RequestInterceptor {
    typealias RequestRetryCompletion = (RetryResult) -> Void
    private var lock = NSLock()
    private var isRefreshing = false
    private var requestsToRetry: [RequestRetryCompletion] = []
    private let bag = DisposeBag()
    
    @Injected var refreshUseCase: RefreshTokenUseCase
    
    init() {
        refreshUseCase
            .succeeded
            .drive(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.lock.lock {
                    self.isRefreshing = false
                    self.requestsToRetry.forEach { $0(.retry) }
                    self.requestsToRetry.removeAll()
                }
            })
            .disposed(by: bag)
        
        refreshUseCase
            .failed
            .drive(onNext: { [weak self] error in
                guard let self = self else { return }
                self.lock.lock {
                    self.isRefreshing = false
                    self.requestsToRetry.forEach { $0(.doNotRetryWithError(error)) }
                    self.requestsToRetry.removeAll()
                    self.toLogin()
                }
            })
            .disposed(by: bag)
    }
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        completion(.success(urlRequest))
    }

    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        lock.lock {
            guard let response = request.response, response.statusCode == 401 else {
                completion(.doNotRetry)
                return
            }
                                    
            requestsToRetry.append(completion)
            
            if !isRefreshing {
                isRefreshing = true
                refreshToken()
            }
        }
    }
    
    func toLogin() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            UIWindow.shared?.rootViewController = UINavigationController(rootViewController: AppScenes.login.viewController)
        }
    }
    
    func refreshToken() {
        refreshUseCase.execute(params: ())
    }
}
