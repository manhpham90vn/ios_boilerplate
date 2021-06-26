//___FILEHEADER___

import UIKit

final class ___FILEBASENAMEASIDENTIFIER___: BaseViewController {
    
    var presenter: ___VARIABLE_productName___Presenter!

    deinit {
        LogInfo("\(type(of: self)) Deinit")
        LeakDetector.instance.expectDeallocate(object: presenter as AnyObject)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func setupUI() {
        super.setupUI()
    }    

    override func bindDatas() {
        super.bindDatas()
        
        presenter.bind(isLoading: isLoading)
    }
    
}

extension ___FILEBASENAMEASIDENTIFIER___: ___VARIABLE_productName___ViewInterface {
    func showAlert(title: String, message: String) {

    }
}
