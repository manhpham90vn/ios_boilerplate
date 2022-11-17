//
//  AppRequestConvertible.swift
//  MyApp
//
//  Created by Manh Pham on 6/29/22.
//

import Foundation
import Alamofire

public protocol AppRequestConvertible: URLRequestConvertible {
    var baseURL: URL { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders { get }
    var path: String { get }
    var parameters: Parameters { get }
    var encoding: ParameterEncoding { get }
    var api: Api { get }
}
