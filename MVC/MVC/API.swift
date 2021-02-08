//
//  API.swift
//  MVC
//
//  Created by Manh Pham on 2/8/21.
//

import Foundation
import Alamofire
import RxSwift

class API {
    
    static func createAccessToken(clientId: String,
                                  clientSecret: String,
                                  code: String,
                                  redirectUri: String?,
                                  state: String?) -> Single<Token> {
        return Single.create { single in
            var params: Parameters = [:]
            params["client_id"] = clientId
            params["client_secret"] = clientSecret
            params["code"] = code
            params["redirect_uri"] = redirectUri
            params["state"] = state
            let request = AF
                .request("https://github.com/login/oauth/access_token",
                                     method: .post,
                                     parameters: params,
                                     encoding: URLEncoding.default,
                                     headers: ["Accept": "application/json"])
                .responseDecodable(of: Token.self) { (response) in
                    switch response.result {
                    case .success(let data):
                        single(.success(data))
                    case .failure(let error):
                        single(.failure(error))
                    }
                }
            return Disposables.create {
                request.cancel()
            }
        }
        .observe(on: MainScheduler.instance)
    }
    
}
