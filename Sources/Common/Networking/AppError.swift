//
//  AppError.swift
//  MyApp
//
//  Created by Manh Pham on 6/29/22.
//

import Foundation

public enum AppError: Error {
    case noInternetConnection
    case actionAlreadyPerforming
    case networkError(api: Api, error: Error, data: Data?)
    case none
}
