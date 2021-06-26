//___FILEHEADER___

import UIKit

protocol ___FILEBASENAMEASIDENTIFIER___Interface {
    
}

final class ___FILEBASENAMEASIDENTIFIER___: ___FILEBASENAMEASIDENTIFIER___Interface, Router {

    unowned let viewController: ___VARIABLE_productName___ViewController

    required init(viewController: ___VARIABLE_productName___ViewController) {
        self.viewController = viewController
        viewController.presenter = ___VARIABLE_productName___Presenter(view: viewController,
                                                   router: self,
                                                   interactor: ___VARIABLE_productName___Interactor())
    }

    deinit {
        LogInfo("\(type(of: self)) Deinit")
    }

}

