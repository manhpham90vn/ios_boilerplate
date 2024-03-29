//
//  RefreshTokenInterceptor.swift
//  AlamofireFeatureTest
//
//  Created by Manh Pham on 6/19/22.
//

import Foundation
import Alamofire
import MPInjector
import UIKit
import RxSwift

final class RefreshTokenInterceptor: RequestInterceptor {
    typealias RequestRetryCompletion = (RetryResult) -> Void
    @Atomic private var isRefreshing = false
    @Inject private var refreshUseCase: RefreshTokenUseCase
    private var requestsToRetry: [RequestRetryCompletion] = []
    private let bag = DisposeBag()
        
    init() {
        refreshUseCase
            .succeeded
            .drive(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.handleRefreshSuccess()
            })
            .disposed(by: bag)
        
        refreshUseCase
            .failed
            .drive(onNext: { [weak self] error in
                guard let self = self else { return }
                self.handleRefreshError(error: error)
            })
            .disposed(by: bag)
    }
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        completion(.success(urlRequest))
    }

    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        guard let response = request.response,
              response.statusCode == 401 else {
            completion(.doNotRetry)
            return
        }
                                
        requestsToRetry.append(completion)
        
        if !isRefreshing {
            isRefreshing = true
            refreshToken()
        }
    }
    
    private func handleRefreshSuccess() {
        isRefreshing = false
        requestsToRetry.forEach { $0(.retry) }
        requestsToRetry.removeAll()
    }
    
    private func handleRefreshError(error: Error) {
        isRefreshing = false
        requestsToRetry.forEach { $0(.doNotRetryWithError(error)) }
        requestsToRetry.removeAll()
        toLogin()
    }
        
    private func toLogin() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            UIWindow.shared?.rootViewController = UINavigationController(rootViewController: AppScenes.login.viewController)
        }
    }
    
    private func refreshToken() {
        refreshUseCase.execute(params: ())
    }
}

private extension Date {
    var millisecondsSince1970: Int64 {
        Int64((timeIntervalSince1970 * 1000.0).rounded())
    }
}
