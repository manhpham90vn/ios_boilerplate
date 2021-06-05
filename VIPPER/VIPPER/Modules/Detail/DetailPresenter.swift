//
//  DetailPresenterInterface.swift
//  VIPPER
//
//  Created by Manh Pham on 06/06/2021.
//

import Foundation

protocol DetailPresenterInterface {
    var view: DetailViewInterface { get set }
    var router: DetailRouterInterface { get set }
    var interactor: DetailInteractorInterface { get set }
}

class DetailPresenter: BasePresenter, DetailPresenterInterface {

    init(view: DetailViewInterface,
         router: DetailRouterInterface,
         interactor: DetailInteractorInterface) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }

    unowned var view: DetailViewInterface
    var router: DetailRouterInterface
    var interactor: DetailInteractorInterface

}
