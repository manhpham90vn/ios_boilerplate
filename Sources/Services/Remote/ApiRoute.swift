//
//  ApiRoute.swift
//  VIPPER
//
//  Created by Manh Pham on 3/16/21.
//

import Foundation
import Moya

protocol RetryRequestable {
    var canRetryRequest: Bool { get }
}

protocol ShowDialogableWhenError {
    var needShowDialogWhenBadStatuCode: Bool { get }
}

enum ApiRouter {
    case createAccessToken(params: AccessTokenParams)
    case userReceivedEvents(params: EventParams)
    case getInfoUser
}

extension ApiRouter: TargetType {
    
    var baseURL: URL {
        switch self {
        case .createAccessToken:
            return URL(string: Configs.shared.env.oauthURL)!
        default:
            return URL(string: Configs.shared.env.apiURL)!
        }
    }
    
    var path: String {
        switch self {
        case .createAccessToken:
            return "/login/oauth/access_token"
        case .userReceivedEvents(let params):
            return "/users/\(params.username)/received_events"
        case .getInfoUser:
            return "/user"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .createAccessToken:
            return .post
        case .userReceivedEvents,
             .getInfoUser:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case let .createAccessToken(params):
            return .requestParameters(parameters: params.dictionary ?? [:], encoding: URLEncoding.default)
        case let .userReceivedEvents(params):
            if let page = params.page {
                return .requestParameters(parameters: ["page": page], encoding: URLEncoding.default)
            } else {
                return .requestPlain
            }
        case .getInfoUser:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["Accept": "application/json"]
    }
    
}

extension ApiRouter: AccessTokenAuthorizable {
    
    var authorizationType: AuthorizationType? {
        switch self {
        case .getInfoUser:
            return .bearer
        default:
            return nil
        }
    }
    
}

extension ApiRouter: RetryRequestable {
    var canRetryRequest: Bool {
        return true
    }
}

extension ApiRouter: ShowDialogableWhenError {
    var needShowDialogWhenBadStatuCode: Bool {
        return true
    }
}
