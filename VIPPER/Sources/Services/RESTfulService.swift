//
//  RESTfulServiceComponent.swift
//  VIPER
//
//  Created by Manh Pham on 2/8/21.
//

import Foundation
import Alamofire
import RxSwift
import Moya

protocol RESTfulService {
    func createAccessToken(params: AccessTokenParams) -> Observable<Token>
    func userReceivedEvents(params: EventParams) -> Observable<[Event]>
    func getInfo() -> Observable<User>
}

final class RESTfulServiceComponent: RESTfulService {

    internal init(apiConnection: ApiConnection) {
        self.apiConnection = apiConnection
    }

    let apiConnection: ApiConnection

    func createAccessToken(params: AccessTokenParams) -> Observable<Token> {
        return apiConnection.request(target: MultiTarget(ApiRouter.createAccessToken(params: params)),
                                     type: Token.self)
    }
    
    func userReceivedEvents(params: EventParams) -> Observable<[Event]> {
        return apiConnection.requestArray(target: MultiTarget(ApiRouter.userReceivedEvents(params: params)),
                                          type: Event.self)
    }
    
    func getInfo() -> Observable<User> {
        return apiConnection.request(target: MultiTarget(ApiRouter.getInfoUser),
                                     type: User.self)
    }
      
}
