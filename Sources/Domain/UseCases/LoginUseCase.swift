//
//  LoginUseCase.swift
//  MyApp
//
//  Created by Manh Pham on 11/28/21.
//

import Foundation
import RxSwift
import RxCocoa
import Resolver

protocol LoginUseCaseInterface {
    func login(url: URL) -> Single<Void>
}

enum LoginUseCaseError: Error {
    case codeNotFound
    case createAccessTokenFailed
    case getUserInfoFailed
    
    var message: String {
        switch self {
        case .codeNotFound:
            return "Can not get code"
        case .createAccessTokenFailed:
            return "Can not get access token"
        case .getUserInfoFailed:
            return "Can not get User Info"
        }
    }
}

final class LoginUseCase {
    @Injected var repo: UserRepositoryInterface
}

extension LoginUseCase: LoginUseCaseInterface {
    func login(url: URL) -> Single<Void> {
        return Single.just(url)
            .flatMap { [weak self] url -> Single<Token> in
                guard let self = self else { return .never() }
                guard let code = url.queryParameters?["code"] else {
                    return .error(LoginUseCaseError.codeNotFound)
                }
                let params = AccessTokenParams(clientId: Configs.shared.env.clientID,
                                               clientSecret: Configs.shared.env.clientSecrets,
                                               code: code)
                return self.repo.createAccessToken(params: params)
            }
            .flatMap { [weak self] token -> Single<User> in
                guard let self = self else { return .never() }
                guard let token = token.accessToken else {
                    return .error(LoginUseCaseError.createAccessTokenFailed)
                }
                self.repo.token = token
                return self.repo.getInfo()
            }
            .flatMap { [weak self] user -> Single<Void> in
                guard let self = self else { return .never() }
                self.repo.user = user
                return .just(())
            }
    }
}
