//
//  DetailViewController.swift
//  VIPER
//
//  Created by Manh Pham on 2/8/21.
//

import UIKit

final class DetailViewController: BaseViewController {

    var presenter: DetailPresenter!

    deinit {
        LogInfo("\(type(of: self)) Deinit")
        LeakDetector.instance.expectDeallocate(object: presenter as AnyObject)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func setupUI() {
        super.setupUI()
    }

    override func bindViewModel() {
        super.bindViewModel()

        presenter.bind(isLoading: isLoading)
    }
    
}

extension DetailViewController: DetailViewInterface {
    func showAlert(title: String, message: String) {

    }
}
