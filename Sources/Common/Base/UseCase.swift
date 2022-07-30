//
//  UseCase.swift
//  MyApp
//
//  Created by Manh Pham on 7/30/22.
//

import Foundation

protocol UseCase {
    associatedtype P
    associatedtype R
    @discardableResult
    func buildUseCase(params: P) -> R
    func execute(params: P)
}

extension UseCase {
    
    func execute(params: P) {
        buildUseCase(params: params)
    }
}
