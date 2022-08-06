//
//  AuthenAdapter.swift
//  AlamofireFeatureTest
//
//  Created by Manh Pham on 6/19/22.
//

import Foundation
import Alamofire
import MPInjector

final class AuthenAdapter: RequestAdapter {
    
    @Inject var local: LocalStorageRepository
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var urlRequest = urlRequest
        if let token = local.getAccessToken() {
            urlRequest.headers.add(.authorization(bearerToken: token))
        }
        completion(.success(urlRequest))
    }
}
