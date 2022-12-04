//
//  DetailRouterInterface.swift
//  VIPPER
//
//  Created by Manh Pham on 06/06/2021.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import MPInjector
import Configs
import Logs

protocol DetailRouterInterface {
    var view: DetailViewInterface? { get }
    func inject(view: DetailViewInterface)
}

final class DetailRouter: DetailRouterInterface {

    weak var view: DetailViewInterface?
    
    func inject(view: DetailViewInterface) {
        self.view = view
    }
    
    deinit {
        if Configs.shared.loggingDeinitEnabled {
            LogInfo("\(Swift.type(of: self)) Deinit")
        }
    }

}
