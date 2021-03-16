//
//  ApiProvider.swift
//  VIPPER
//
//  Created by Manh Pham on 3/16/21.
//

import Foundation
import Moya
import RxSwift
import Alamofire

final class ApiProvider<Target: TargetType>: MoyaProvider<Target> {
    
    init(plugins: [PluginType]) {
        var plugins = plugins
        plugins.append(NetworkIndicatorPlugin.indicatorPlugin())
        if Configs.shared.loggingEnabled {
            plugins.append(NetworkLoggerPlugin(configuration: .init(logOptions: .verbose)))
        }
        super.init(plugins: plugins)
    }
    
    func request(target: Target) -> Observable<Response> {
        return connectedToInternet()
            .take(1)
            .flatMapLatest({ _ -> Observable<Response> in
                return self
                    .rx
                    .request(target)
                    .filterSuccessfulStatusCodes()
                    .do(onError: { error in
                        self.handleError(error: error)
                    })
                    .asObservable()
                    .catchError { (error) -> Observable<Response> in
                        return self.catchJustCompleted(error: error)
                    }
            })
        }
    
    private func handleError(error: Error) {
        if let error = error as? MoyaError {
            switch error {
            case .statusCode(let response):
                if response.statusCode == 401 {
                    print("Unauthorized")
                }
            case .underlying(let error, _):
                if let error = error as? AFError {
                    switch error {
                    case .sessionTaskFailed(let error as NSError):
                        if error.domain == NSURLErrorDomain {
                            switch error.code {
                            case NSURLErrorTimedOut:
                                print("Timeout")
                            case NSURLErrorDataNotAllowed:
                                print("No connect")
                            default:
                                break
                            }
                        }
                    default:
                        break
                    }
                }
            default:
                break
            }
        }
    }
    
    private func catchJustCompleted(error: Error) -> Observable<Response> {
        if let error = error as? MoyaError {
            switch error {
            case .statusCode(let response):
                if response.statusCode == 401 {
                    return .empty()
                }
            case .underlying(let error, _):
                if let error = error as? AFError {
                    switch error {
                    case .sessionTaskFailed(let error as NSError):
                        if error.domain == NSURLErrorDomain {
                            switch error.code {
                            case NSURLErrorTimedOut:
                                return .empty()
                            case NSURLErrorDataNotAllowed:
                                return .empty()
                            default:
                                break
                            }
                        }
                    default:
                        break
                    }
                }
            default:
                break
            }
        }
        return .error(error)
    }
    
}
