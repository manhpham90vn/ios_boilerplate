//
//  DetailViewController.swift
//  VIPER
//
//  Created by Manh Pham on 2/8/21.
//

import UIKit

final class DetailViewController: BaseViewController {

    @Injected var presenter: DetailPresenterInterface

    deinit {
        if Configs.shared.loggingDeinitEnabled {
            LogInfo("\(Swift.type(of: self)) Deinit")
        }
        LeakDetector.instance.expectDeallocate(object: presenter as AnyObject)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad(view: self)
    }

    override func setupUI() {
        super.setupUI()
    }

    override func bindDatas() {
        super.bindDatas()
    }
    
}

extension DetailViewController: DetailViewInterface {}
