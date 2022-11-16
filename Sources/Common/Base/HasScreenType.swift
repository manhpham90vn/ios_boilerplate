//
//  HasScreenType.swift
//  MyApp
//
//  Created by Manh Pham on 16/11/2022.
//

import Foundation

enum ScreenType {
    case login
    case main
    case detail
    case none
}

protocol HasScreenType {
    var screenType: ScreenType { get }
}
