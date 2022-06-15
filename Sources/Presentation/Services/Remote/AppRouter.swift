//
//  AppRouter.swift
//  MyApp
//
//  Created by Manh Pham on 6/12/22.
//

import Foundation
import Moya

enum AppRouter {
    case login(email: String, password: String)
    case userInfo
    case paging(page: Int)
    case refreshToken(token: String)
}

extension AppRouter: TargetType {
    
    var baseURL: URL {
        URL(string: Configs.shared.env.baseURL)!
    }
    
    var path: String {
        switch self {
        case .login:
            return "login"
        case .userInfo:
            return "user"
        case .paging:
            return "paging"
        case .refreshToken:
            return "refreshToken"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login:
            return .post
        case .userInfo:
            return .get
        case .paging:
            return .get
        case .refreshToken:
            return .post
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case let .login(email, password):
            let encode = ["email": email, "password": password]
            return .requestJSONEncodable(encode)
        case .userInfo:
            return .requestPlain
        case let .paging(page):
            return .requestParameters(parameters: ["page": page], encoding: URLEncoding.default)
        case let .refreshToken(token):
            let encode = ["token": token]
            return .requestJSONEncodable(encode)
        }
    }
    
    var headers: [String : String]? {
        return ["Accept": "application/json"]
    }
    
}

extension AppRouter: AccessTokenAuthorizable {
    
    var authorizationType: AuthorizationType? {
        switch self {
        case .userInfo, .paging:
            return .bearer
        default:
            return nil
        }
    }
    
}

extension AppRouter: AppError {}

extension AppRouter: Retryable {}
