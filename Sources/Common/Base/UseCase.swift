//
//  UseCase.swift
//  MyApp
//
//  Created by Manh Pham on 7/30/22.
//

import Foundation

protocol UseCase: AnyObject {
    associatedtype P
    associatedtype R
    var cacheParams: P? { get set }
    @discardableResult
    func buildUseCase(params: P) -> R
    func execute(params: P)
    func retry()
}

extension UseCase {
    
    func execute(params: P) {
        cacheParams = params
        buildUseCase(params: params)
    }
    
    func retry() {
        if let cacheParams = cacheParams {
            execute(params: cacheParams)
        }
    }
}
