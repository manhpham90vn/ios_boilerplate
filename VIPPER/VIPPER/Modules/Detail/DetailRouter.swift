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

class DetailRouter: BaseRouter, DetailRouterInterface {

    private(set) var viewController: DetailViewController

    override init() {
        viewController = UIStoryboard(name: "Detail", bundle: nil).instantiateInitialViewController() as! DetailViewController
        super.init()
        viewController.presenter = DetailPresenter(view: viewController,
                                                   router: self,
                                                   interactor: DetailInteractor())
    }

}
