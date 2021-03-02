//
//  API.swift
//  MVC
//
//  Created by Manh Pham on 2/8/21.
//

import Foundation
import Alamofire
import RxSwift

protocol Service {
    func createAccessToken(clientId: String,
                                clientSecret: String,
                                code: String,
                                redirectUri: String?,
                                state: String?) -> Single<Token>
    func userReceivedEvents(username: String, page: Int) -> Single<[Event]>
    func getInfo() -> Single<User>
}

class API: Service {
    
    static let shared = API()
    private init() {}
    
    func createAccessToken(clientId: String,
                                  clientSecret: String,
                                  code: String,
                                  redirectUri: String?,
                                  state: String?) -> Single<Token> {
        return Single.create { single in
            
            // params
            var params: Parameters = [:]
            params["client_id"] = clientId
            params["client_secret"] = clientSecret
            params["code"] = code
            params["redirect_uri"] = redirectUri
            params["state"] = state
            
            // header
            var header = HTTPHeaders()
            header.add(HTTPHeader.accept("application/json"))
            
            let request = AF
                .request(Configs.oauthURL,
                                     method: .post,
                                     parameters: params,
                                     encoding: URLEncoding.default,
                                     headers: header)
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
    
    func userReceivedEvents(username: String, page: Int) -> Single<[Event]> {
        return Single.create { single in
            
            // params
            var params: Parameters = [:]
            params["page"] = page
            
            // header
            var header = HTTPHeaders()
            header.add(HTTPHeader.accept("application/json"))
            
            let url = Configs.apiURL + "/users/\(username)/received_events"
            
            let request = AF
                .request(url,
                         method: .get,
                         parameters: params,
                         encoding: URLEncoding.default,
                         headers: header)
                .responseDecodable(of: [Event].self) { (response) in
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
    
    func getInfo() -> Single<User> {
        
        return Single.create { single in
            
            // header
            var header = HTTPHeaders()
            header.add(HTTPHeader.accept("application/json"))
            if let token = AuthManager.shared.token {
                header.add(HTTPHeader.authorization(bearerToken: token))
            }
            
            let url = Configs.apiURL + "/user"
            
            let request = AF
                .request(url,
                         method: .get,
                         parameters: nil,
                         encoding: URLEncoding.default,
                         headers: header)
                .responseDecodable(of: User.self) { (response) in
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
