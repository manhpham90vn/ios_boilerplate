//
//  DetailViewController.swift
//  VIPER
//
//  Created by Manh Pham on 2/8/21.
//

import UIKit
import Resolver

struct DetailViewControllerParams {
    var event: Paging
}

final class DetailViewController: BaseViewController {

    @Injected var presenter: DetailPresenterInterface
    private var params: DetailViewControllerParams?

    deinit {
        if Configs.shared.loggingDeinitEnabled {
            LogInfo("\(Swift.type(of: self)) Deinit")
        }
        LeakDetector.instance.expectDeallocate(object: presenter as AnyObject)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.inject(view: self)
    }

    func inject(params: DetailViewControllerParams) {
        self.params = params
    }
    
    override func setupUI() {
        super.setupUI()
        
        navigationItem.title = params?.event.name
    }

    override func bindDatas() {
        super.bindDatas()
    }
    
}

extension DetailViewController: DetailViewInterface {}
