//
//  DetailViewController.swift
//  VIPER
//
//  Created by Manh Pham on 2/8/21.
//

import UIKit

struct DetailViewControllerParams {
    var event: Event
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
        
        navigationItem.title = params?.event.repo?.name
    }

    override func bindDatas() {
        super.bindDatas()
    }
    
}

extension DetailViewController: DetailViewInterface {}
