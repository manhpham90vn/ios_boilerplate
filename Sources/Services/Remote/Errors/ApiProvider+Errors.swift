//
//  ApiProvider+Errors.swift
//  MyApp
//
//  Created by Manh Pham on 12/31/21.
//

import Foundation

extension ApiProvider {
    
    // api UserReceivedEvents
    func userReceivedEventsErrors(target: Target,
                                  response: UserReceivedEventsError,
                                  appCommonError: AppCommonErrorInterface,
                                  error: Error) -> Single<Response> {
        return AppHelper
            .shared
            .showAlertRx(title: appCommonError.errorTitle,
                         message: response.message ?? appCommonError.errorMessage,
                         cancel: appCommonError.buttonLeft,
                         ok: "Thử lại")
            .flatMap { [weak self] in
                self?.request(target: target) ?? .error(error)
            }
    }
}
