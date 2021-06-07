//
//  DetailInteractorInterface.swift
//  VIPPER
//
//  Created by Manh Pham on 06/06/2021.
//

import Foundation

protocol DetailInteractorInterface {

}

class DetailInteractor: DetailInteractorInterface { // swiftlint:disable:this final_class

    deinit {
        print("\(type(of: self)) Deinit")
    }

}
