//
//  ApiErrorHandler.swift
//  MyApp
//
//  Created by Manh Pham on 7/31/22.
//

import Foundation
import Alamofire

final class ApiErrorHandler {
    
    func handle(error: Error, callback: @escaping () -> Void = {}) {
        if let error = error as? AppError {
            switch error {
            case .noInternetConnection:
                let alert = UIAlertController(title: "Error", message: "No Internet Connection", preferredStyle: .alert)
                alert.addAction(.init(title: "Cancel", style: .cancel))
                alert.addAction(.init(title: "Retry", style: .default) { _ in
                    callback()
                })
                AppHelper.shared.topViewController()?.present(alert, animated: true, completion: nil)
            case .actionAlreadyPerforming:
                AppHelper.shared.showAlert(title: "Error", message: "Action Already Performing", completion: nil)
            case let .networkError(api, error, data):
                if let message = try? JSONDecoder().decode(ErrorResponse.self, from: data ?? Data()).message {
                    AppHelper.shared.showAlert(title: "Error api: \(api.rawValue)", message: message, completion: nil)
                } else {
                    AppHelper.shared.showAlert(title: "Error api: \(api.rawValue)", message: error.localizedDescription, completion: nil)
                }
            }
        }
    }
    
}
