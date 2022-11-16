//
//  BaseViewController.swift
//  VIPPER
//
//  Created by Manh Pham on 3/5/21.
//

import UIKit
import NSObject_Rx

class BaseViewController: UIViewController, HasDisposeBag, HasScreenType {
    
    var screenType: ScreenType {
        .none
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        bindDatas()
    }

    func setupUI() {}

    func bindDatas() {}

}
