//
//  EntityConvertibleType.swift
//  MyApp
//
//  Created by Manh Pham on 6/12/22.
//

import Foundation

protocol EntityConvertibleType {
    associatedtype EntityType

    func asEntity() -> EntityType
}
