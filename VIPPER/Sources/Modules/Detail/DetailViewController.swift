//
//  DetailViewController.swift
//  VIPER
//
//  Created by Manh Pham on 2/8/21.
//

import UIKit

final class DetailViewController: BaseViewController {

    var presenter: DetailPresenterInterface!

    deinit {
        print("\(type(of: self)) Deinit")
        LeakDetector.instance.expectDeallocate(object: presenter as AnyObject)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
}

extension DetailViewController: DetailViewInterface {
    func showAlert(title: String, message: String) {

    }

    func showLoading(isLoading: Bool) {
        
    }
}
