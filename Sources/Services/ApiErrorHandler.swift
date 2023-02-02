//
//  ApiErrorHandler.swift
//  MyApp
//
//  Created by Manh Pham on 7/31/22.
//

import Foundation
import Alamofire
import MPInjector

/// @mockable
protocol ApiErrorHandler {
    func handle(error: Error, screenType: ScreenType, callback: (() -> Void)?)
}

final class ApiErrorHandlerImp: ApiErrorHandler {
    
    @Inject var dialog: DialogManager
    
    func handle(error: Error, screenType: ScreenType, callback: (() -> Void)?) {
        if let error = error as? AppError {
            switch error {
            case .noInternetConnection:
                dialog.showDialog(typeDialog: .retryDialog,
                                  title: "Error",
                                  message: "No Internet Connection",
                                  retryButtonLabel: nil,
                                  closeButtonLabel: nil,
                                  callbackRetry: {
                                        callback?()
                                    },
                                  callbackClose: nil)
            case .actionAlreadyPerforming:
                dialog.showDialog(typeDialog: .closeDialog,
                                  title: "Error",
                                  message: "Action Already Performing",
                                  retryButtonLabel: nil,
                                  closeButtonLabel: nil,
                                  callbackRetry: nil,
                                  callbackClose: nil)
            case let .networkError(api, error, data):
                if let message = try? JSONDecoder().decode(ErrorResponse.self, from: data ?? Data()).message {
                    dialog.showDialog(typeDialog: .closeDialog,
                                      title: "Error api \(api.rawValue)",
                                      message: message,
                                      retryButtonLabel: nil,
                                      closeButtonLabel: nil,
                                      callbackRetry: nil,
                                      callbackClose: nil)
                } else {
                    dialog.showDialog(typeDialog: .closeDialog,
                                      title: "Error api \(api.rawValue)",
                                      message: error.localizedDescription,
                                      retryButtonLabel: nil,
                                      closeButtonLabel: nil,
                                      callbackRetry: nil,
                                      callbackClose: nil)
                }
            case .none:
                break
            }
        }
    }
    
}
