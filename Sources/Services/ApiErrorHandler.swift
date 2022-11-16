//
//  ApiErrorHandler.swift
//  MyApp
//
//  Created by Manh Pham on 7/31/22.
//

import Foundation
import Alamofire
import MPInjector

final class ApiErrorHandler {
    
    @Inject var dialog: DialogManager
    
    func handle(error: Error, screenType: ScreenType, callback: @escaping () -> Void = {}) {
        if let error = error as? AppError {
            switch error {
            case .noInternetConnection:
                dialog.showDialog(typeDialog: .retryDialog, title: "Error", message: "No Internet Connection", callbackRetry: {
                    callback()
                })
            case .actionAlreadyPerforming:
                dialog.showDialog(typeDialog: .closeDialog, title: "Error", message: "Action Already Performing")
            case let .networkError(api, error, data):
                if let message = try? JSONDecoder().decode(ErrorResponse.self, from: data ?? Data()).message {
                    dialog.showDialog(typeDialog: .closeDialog, title: "Error api: \(api.rawValue) screen: \(screenType)", message: message)
                } else {
                    dialog.showDialog(typeDialog: .closeDialog, title: "Error api: \(api.rawValue) screen: \(screenType)", message: error.localizedDescription)
                }
            }
        }
    }
    
}
