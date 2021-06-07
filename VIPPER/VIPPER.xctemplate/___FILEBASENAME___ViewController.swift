//___FILEHEADER___

import UIKit

final class ___FILEBASENAMEASIDENTIFIER___: BaseViewController {
    
    var presenter: ___VARIABLE_productName___PresenterInterface!

    deinit {
        LogInfo("\(type(of: self)) Deinit")
        LeakDetector.instance.expectDeallocate(object: presenter as AnyObject)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

extension ___FILEBASENAMEASIDENTIFIER___: ___VARIABLE_productName___ViewInterface {
    func showAlert(title: String, message: String) {

    }

    func showLoading(isLoading: Bool) {
        
    }
}
