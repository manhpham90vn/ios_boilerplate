//
//  ApiErrorHandler.swift
//  MyApp
//
//  Created by Manh Pham on 7/31/22.
//

import Foundation
import Alamofire

final class ApiErrorHandler {
    
    func handle(error: Error) {
        if let error = error as? AppError {
            switch error {
            case .noInternetConnection:
                AppHelper.shared.showAlert(title: "Error", message: "No Internet Connection", completion: nil)
            case .actionAlreadyPerforming:
                AppHelper.shared.showAlert(title: "Error", message: "Action Already Performing", completion: nil)
            case let .networkError(error, api, data):
                if let message = try? JSONDecoder().decode(ErrorResponse.self, from: data ?? Data()).message {
                    AppHelper.shared.showAlert(title: "Error api: \(api.rawValue)", message: message, completion: nil)
                } else {
                    AppHelper.shared.showAlert(title: "Error api: \(api.rawValue)", message: error.localizedDescription, completion: nil)
                }
            }
        }
    }
    
}
