//
//  AuthenAdapter.swift
//  AlamofireFeatureTest
//
//  Created by Manh Pham on 6/19/22.
//

import Foundation
import Alamofire

// TODO: add protocol to check add token if needed example login api not need bearer token
final class AuthenAdapter: RequestAdapter {
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var urlRequest = urlRequest
        urlRequest.headers.add(.authorization(bearerToken: UserDefaults.standard.value(forKey: "token") as? String ?? ""))
        completion(.success(urlRequest))
    }
}
