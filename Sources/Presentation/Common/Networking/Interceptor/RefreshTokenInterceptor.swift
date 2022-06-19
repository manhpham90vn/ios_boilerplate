//
//  RefreshTokenInterceptor.swift
//  AlamofireFeatureTest
//
//  Created by Manh Pham on 6/19/22.
//

import Foundation
import Alamofire
import Resolver

final class RefreshTokenInterceptor: RequestInterceptor {
    typealias RequestRetryCompletion = (RetryResult) -> Void
    private var lock = NSLock()
    private var isRefreshing = false
    private var requestsToRetry: [RequestRetryCompletion] = []
    
    @Injected var local: LocalStorageRepository
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        completion(.success(urlRequest))
    }
    
    // TODO: check some time call refresh token 2 time
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        lock.lock {
            guard let response = request.response, response.statusCode == 401 else {
                completion(.doNotRetry)
                return
            }
                        
            requestsToRetry.append(completion)
            
            if !isRefreshing {
                isRefreshing = true
                refreshToken { [weak self] result in
                    guard let self = self else { return }
                    self.lock.lock {
                        switch result {
                        case let .success(token):
                            self.local.setAccessToken(newValue: token)
                            self.requestsToRetry.forEach { $0(.retry) }
                            self.requestsToRetry.removeAll()
                        case let .failure(error):
                            LogError("refreshToken error")
                            self.requestsToRetry.forEach { $0(.doNotRetryWithError(error)) }
                            self.requestsToRetry.removeAll()
                        }
                        self.isRefreshing = false
                    }
                }
            }
        }
    }
    
    // TODO: use AppNetwork.default or  but lead can not get callback
    func refreshToken(completion: @escaping (Result<String, Error>) -> Void) {
        AF.request("\(Configs.shared.env.baseURL)refreshToken",
                   method: .post,
                   parameters: ["token": local.getRefreshToken() ?? ""],
                   encoding: URLEncoding.httpBody)
            .responseDecodable(of: RefreshTokenResponse.self) { response in
                switch response.result {
                case .success(let data):
                    completion(.success(data.token ?? ""))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
