//
//  AppNetwork.swift
//  AlamofireFeatureTest
//
//  Created by Manh Pham on 6/19/22.
//

import Foundation
import Alamofire
import RxSwift

final class AppNetwork {
    static let `default` = AppNetwork()
    
    private init() {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 3
        config.timeoutIntervalForResource = 3
        
        // Adapter
        let xTypeAdapter = XTypeAdapter()
        let authenAdapter = AuthenAdapter()
        
        // Interceptors
        let refreshTokenInterceptor = RefreshTokenInterceptor()
        let retryPolicy = RetryPolicy(retryLimit: 3, retryableHTTPMethods: [.get], retryableHTTPStatusCodes: [])
        
        // Event Monitors
        var eventMonitors: [EventMonitor] = []
        #if DEBUG
        if Configs.shared.loggingAPIEnabled {
            let logger = AppMonitor()
            eventMonitors.append(logger)
        }
        #endif
        
        // Interceptor
        let compositeInterceptor = Interceptor(adapters: [xTypeAdapter, authenAdapter],
                                               interceptors: [refreshTokenInterceptor, retryPolicy])
        let session = Session(interceptor: compositeInterceptor, eventMonitors: eventMonitors)
        self.session = session
    }
    
    private let session: Session!
    
    func cancelAllRequests() {
        session.cancelAllRequests()
    }
    
    func request<T: Decodable>(route: AppRequestConvertible,
                               type: T.Type,
                               completion: @escaping (Result<T, Error>) -> Void) -> DataRequest {
        let request = session
            .request(route)
            .cURLDescription(calling: { curl in
                if Configs.shared.loggingcURLEnabled {
                    LogInfo(curl)
                }
            })
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case let .success(data):
                    completion(.success(data))
                case let .failure(error):
                    completion(.failure(error))
                }
            }
        return request
    }
    
    func request<T: Decodable>(route: AppRequestConvertible,
                               type: T.Type) -> Single<T> {
        Single<T>.create { single in
            let request = self.request(route: route, type: T.self) { result in
                switch result {
                case let .success(data):
                    single(.success(data))
                case let .failure(error):
                    single(.failure(error))
                }
            }
            return Disposables.create {
                request.cancel()
            }
        }
    }
}
