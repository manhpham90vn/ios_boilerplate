//
//  DetailRouterInterface.swift
//  VIPPER
//
//  Created by Manh Pham on 06/06/2021.
//

import Foundation
import UIKit

protocol DetailRouterInterface {

}

final class DetailRouter: DetailRouterInterface {

    deinit {
        if Configs.shared.loggingDeinitEnabled {
            LogInfo("\(Swift.type(of: self)) Deinit")
        }
    }

}
