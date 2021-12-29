//
//  LoginUseCase.swift
//  MyApp
//
//  Created by Manh Pham on 11/28/21.
//

import Foundation

protocol LoginUseCaseInterface {
    func login(url: URL) -> Observable<Void>
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
    func login(url: URL) -> Observable<Void> {
        return Observable.just(url)
            .flatMap { [weak self] url -> Observable<Token> in
                guard let self = self else { return .empty() }
                guard let code = url.queryParameters?["code"] else {
                    return .error(LoginUseCaseError.codeNotFound)
                }
                let params = AccessTokenParams(clientId: Configs.shared.env.clientID,
                                               clientSecret: Configs.shared.env.clientSecrets,
                                               code: code)
                return self.repo.createAccessToken(params: params)
            }
            .flatMap { [weak self] token -> Observable<User> in
                guard let self = self else { return .empty() }
                guard let token = token.accessToken else {
                    return .error(LoginUseCaseError.createAccessTokenFailed)
                }
                self.repo.token = token
                return self.repo.getInfo()
            }
            .flatMap { [weak self] user -> Observable<Void> in
                guard let self = self else { return .empty() }
                self.repo.user = user
                return .just(())
            }
    }
}
