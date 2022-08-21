//
//  AppNetwork.swift
//  AlamofireFeatureTest
//
//  Created by Manh Pham on 6/19/22.
//

import Foundation
import Alamofire
import RxSwift

protocol AppNetworkInterface {
    func request<T: Decodable>(route: AppRequestConvertible,
                               type: T.Type) -> Single<T>
    func requestRefreshable<T: Decodable>(route: AppRequestConvertible,
                                          type: T.Type) -> Single<T>
}

final class AppNetwork: AppNetworkInterface {

    private let session: Session!
    private let sessionRefreshable: Session!
    
    init() {
        let config = URLSessionConfiguration.af.default
        config.timeoutIntervalForRequest = 30
        config.timeoutIntervalForResource = 30
        config.allowsCellularAccess = true
        
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
        
        // create session
        self.sessionRefreshable = Session(configuration: config, interceptor: compositeInterceptor, eventMonitors: eventMonitors)
        self.session = Session(configuration: config, eventMonitors: eventMonitors)
    }
    
    private func request<T: Decodable>(session: Session,
                                       route: AppRequestConvertible,
                                       type: T.Type,
                                       completion: @escaping (Result<T, Error>) -> Void) -> DataRequest {
        let request = session
            .request(route)
            .validate(statusCode: 200...300)
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
                    completion(.failure(AppError.networkError(api: route.api, error: error, data: response.data)))
                }
            }
        return request
    }
    
    private func request<T: Decodable>(session: Session,
                                       route: AppRequestConvertible,
                                       type: T.Type) -> Single<T> {
        Single<T>.create { [weak self] single in
            guard let self = self else {
                return Disposables.create()
            }
            let request = self.request(session: session, route: route, type: T.self) { result in
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
    
    func request<T: Decodable>(route: AppRequestConvertible,
                               type: T.Type) -> Single<T> {
        return request(session: session, route: route, type: type)
    }
    
    func requestRefreshable<T: Decodable>(route: AppRequestConvertible,
                                          type: T.Type) -> Single<T> {
        return request(session: sessionRefreshable, route: route, type: type)
    }
}
