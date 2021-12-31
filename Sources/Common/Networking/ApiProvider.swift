//
//  ApiProvider.swift
//  VIPPER
//
//  Created by Manh Pham on 3/16/21.
//

final class ApiProvider<Target: TargetType>: MoyaProvider<Target> {
    
    init(plugins: [PluginType]) {
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
                    .asObservable()
                    .catchError { [weak self] (error) -> Observable<Response> in
                        guard let self = self else { return .empty() }
                        return self.handleRetry(error: error, target: target)
                    }
            })
    }

    private func handleRetry(error: Error, target: Target) -> Observable<Response> {
        guard let appCommonError = (target as? MultiTarget)?.target as? AppCommonErrorInterface else { return .empty() }
        guard appCommonError.needHandleError else { return .empty() }
        if let error = error as? MoyaError {
            switch error {
            case .underlying(let error, _):
                if let error = error as? AFError {
                    switch error {
                    case .sessionTaskFailed:
                        return AppHelper
                            .shared
                            .showAlertRx(title: appCommonError.errorTitle,
                                         message: appCommonError.errorMessage,
                                         cancel: appCommonError.buttonLeft,
                                         ok: appCommonError.buttonRight)
                            .flatMap { [weak self] in
                                self?.request(target: target) ?? .empty()
                            }
                    default:
                        break
                    }
                }
            case .statusCode(let response), .jsonMapping(let response), .objectMapping(_, let response):
                // handle error of each api here
                if let response = try? response.map(UserReceivedEventsError.self) {
                    return userReceivedEventsErrors(target: target,
                                                    response: response,
                                                    appCommonError: appCommonError)
                }
            default:
                break
            }
        }
        return .empty()
    }
}
