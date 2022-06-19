//
//  AuthenAdapter.swift
//  AlamofireFeatureTest
//
//  Created by Manh Pham on 6/19/22.
//

import Foundation
import Alamofire
import Resolver

// TODO: add protocol to check add token if needed example login api not need bearer token
final class AuthenAdapter: RequestAdapter {
    
    @Injected var local: LocalStorageRepository
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var urlRequest = urlRequest
        urlRequest.headers.add(.authorization(bearerToken: local.getAccessToken() ?? ""))
        completion(.success(urlRequest))
    }
}
