//
//  RESTfulServiceComponent.swift
//  VIPER
//
//  Created by Manh Pham on 2/8/21.
//

import Foundation
import RxSwift
import RxCocoa
import Moya

protocol RESTfulService {
    func createAccessToken(params: AccessTokenParams) -> Single<Token>
    func userReceivedEvents(params: EventParams) -> Single<[Event]>
    func getInfo() -> Single<User>
}

final class RESTfulServiceComponent: RESTfulService {

    func createAccessToken(params: AccessTokenParams) -> Single<Token> {
        return ApiConnection.shared.request(target: MultiTarget(ApiRouter.createAccessToken(params: params)),
                                            type: Token.self)
    }
    
    func userReceivedEvents(params: EventParams) -> Single<[Event]> {
        return ApiConnection.shared.requestArray(target: MultiTarget(ApiRouter.userReceivedEvents(params: params)),
                                                 type: Event.self)
    }
    
    func getInfo() -> Single<User> {
        return ApiConnection.shared.request(target: MultiTarget(ApiRouter.getInfoUser),
                                            type: User.self)
    }
      
}
