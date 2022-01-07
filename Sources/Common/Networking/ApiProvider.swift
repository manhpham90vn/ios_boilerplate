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
    
    func request(target: Target) -> Single<Response> {
        return rx
            .request(target)
            .filterSuccessfulStatusCodes()
            .autoRetry(delay: .constant(time: 1), shouldRetry: { (error) -> Bool in
                if let error = error as? MoyaError {
                    switch error {
                    case .underlying(let error, _):
                        if let error = error as? AFError {
                            switch error {
                            case .sessionTaskFailed:
                                return true
                            default:
                                break
                            }
                        }
                    default:
                        break
                    }
                }
                return false
            })
            .catch { [weak self] (error) -> Single<Response> in
                guard let self = self else { return .never() }
                return self.handleRetry(error: error, target: target)
            }
    }

    private func handleRetry(error: Error, target: Target) -> Single<Response> {
        guard let appCommonError = (target as? MultiTarget)?.target as? AppCommonErrorInterface else { return .error(error) }
        guard appCommonError.needHandleError else { return .error(error) }
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
                            .flatMap { [weak self] _ -> Single<Response> in
                                self?.request(target: target) ?? .error(error)
                            }
                    default:
                        break
                    }
                }
            case .statusCode(let response):
                // handle error of each api here
                if let response = try? response.map(UserReceivedEventsError.self) {
                    return userReceivedEventsErrors(target: target,
                                                    response: response,
                                                    appCommonError: appCommonError,
                                                    error: error)
                }
            default:
                break
            }
        }
        return .error(error)
    }
}
