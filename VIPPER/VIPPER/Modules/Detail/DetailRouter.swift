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

class DetailRouter: DetailRouterInterface, Router {

    unowned var viewController: DetailViewController

    required init(viewController: DetailViewController) {
        self.viewController = viewController
        viewController.presenter = DetailPresenter(view: viewController,
                                                   router: self,
                                                   interactor: DetailInteractor())
    }

    deinit {
        print("\(type(of: self)) Deinit")
    }

}
