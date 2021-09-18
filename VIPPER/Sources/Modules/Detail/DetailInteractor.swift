//
//  DetailInteractorInterface.swift
//  VIPPER
//
//  Created by Manh Pham on 06/06/2021.
//

import Foundation

protocol DetailInteractorInterface {

}

final class DetailInteractor: DetailInteractorInterface {

    deinit {
        if Configs.shared.loggingDeinitEnabled {
            LogInfo("\(Swift.type(of: self)) Deinit")
        }
    }

}
