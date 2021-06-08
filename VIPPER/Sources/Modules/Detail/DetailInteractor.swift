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
        LogInfo("\(type(of: self)) Deinit")
    }

}
