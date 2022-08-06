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
    
    static var lastFailedDate: Int64?
    
    init() {
        refreshUseCase
            .succeeded
            .drive(onNext: { [weak self] _ in
                guard let self = self else { return }
                RefreshTokenInterceptor.lastFailedDate = nil
                self.isRefreshing = false
                self.requestsToRetry.forEach { $0(.retry) }
                self.requestsToRetry.removeAll()
            })
            .disposed(by: bag)
        
        refreshUseCase
            .failed
            .drive(onNext: { [weak self] error in
                guard let self = self else { return }
                RefreshTokenInterceptor.lastFailedDate = Date().millisecondsSince1970
                self.isRefreshing = false
                self.requestsToRetry.forEach { $0(.doNotRetryWithError(error)) }
                self.requestsToRetry.removeAll()
                self.toLogin()
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
        
        if !isRefreshing, checkRepeatRefreshToken() {
            isRefreshing = true
            refreshToken()
        }
    }
    
    private func checkRepeatRefreshToken() -> Bool {
        let timeDiff = Date().millisecondsSince1970 - (RefreshTokenInterceptor.lastFailedDate ?? Date().millisecondsSince1970)
        if RefreshTokenInterceptor.lastFailedDate != nil {
            return timeDiff > 30_000
        } else {
            return true
        }
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
