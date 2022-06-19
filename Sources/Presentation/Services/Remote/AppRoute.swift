//
//  AppRoute.swift
//  AlamofireFeatureTest
//
//  Created by Manh Pham on 6/19/22.
//

import Foundation
import Alamofire

enum AppRoute {
    case login(username: String, password: String)
    case getUserInfo
    case getList(page: Int)
    case refreshToken(token: String)
}

extension AppRoute: URLRequestConvertible {

    var baseURL: URL {
        return URL(string: Configs.shared.env.baseURL)!
    }
    
    var method: HTTPMethod {
        switch self {
        case .login:
            return .post
        case .getUserInfo:
            return .get
        case .getList:
            return .get
        case .refreshToken:
            return .post
        }
    }
    
    var headers: HTTPHeaders {
        switch self {
        default:
            return HTTPHeaders.default
        }
    }
    
    var path: String {
        switch self {
        case .login:
            return "login"
        case .getUserInfo:
            return "user"
        case .getList:
            return "paging"
        case .refreshToken:
            return "refreshToken"
        }
    }
    
    var parameters: Parameters {
        switch self {
        case let .login(username, password):
            return ["email": username, "password": password]
        case .getUserInfo:
            return [:]
        case let .getList(page):
            return ["page": page]
        case let .refreshToken(token):
            return ["token": token]
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .login:
            return URLEncoding.httpBody
        case .getUserInfo:
            return URLEncoding.default
        case .getList:
            return URLEncoding.queryString
        case .refreshToken:
            return URLEncoding.httpBody
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.method = method
        request.headers = headers
        return try encoding.encode(request.asURLRequest(), with: parameters)
    }
}
