//
//  AppNetwork.swift
//  AlamofireFeatureTest
//
//  Created by Manh Pham on 6/19/22.
//

import Foundation
import Alamofire
import RxSwift

public protocol AppNetworkInterface {
    func request<T: Decodable>(route: AppRequestConvertible,
                               type: T.Type) -> Single<T>
    func requestRefreshable<T: Decodable>(route: AppRequestConvertible,
                                          type: T.Type) -> Single<T>
    
    func setup(config: URLSessionConfiguration, adapters: [RequestAdapter], interceptors: [RequestInterceptor], eventMonitors: [EventMonitor] )
}

public final class AppNetwork: AppNetworkInterface {

    private var session: Session!
    private var sessionRefreshable: Session!
    
    public init() {}
    
    public func setup(config: URLSessionConfiguration, adapters: [RequestAdapter], interceptors: [RequestInterceptor], eventMonitors: [EventMonitor] ) {
        // Interceptor
        let compositeInterceptor = Interceptor(adapters: adapters,
                                               interceptors: interceptors)
        // create session
        self.sessionRefreshable = Session(configuration: config, interceptor: compositeInterceptor, eventMonitors: eventMonitors)
        self.session = Session(configuration: config, eventMonitors: eventMonitors)
    }
    
    func request<T: Decodable>(session: Session,
                               route: AppRequestConvertible,
                               type: T.Type,
                               completion: @escaping (Result<T, Error>) -> Void) -> DataRequest {
        let request = session
            .request(route)
            .validate(statusCode: 200...300)
            .cURLDescription(calling: { curl in
                if Configs.shared.loggingAPIEnabled {
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
    
    func request<T: Decodable>(session: Session,
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
    
    public func request<T: Decodable>(route: AppRequestConvertible,
                                      type: T.Type) -> Single<T> {
        return request(session: session, route: route, type: type)
    }
    
    public func requestRefreshable<T: Decodable>(route: AppRequestConvertible,
                                                 type: T.Type) -> Single<T> {
        return request(session: sessionRefreshable, route: route, type: type)
    }
}
