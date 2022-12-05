//
//  BaseViewController.swift
//  VIPPER
//
//  Created by Manh Pham on 3/5/21.
//

import UIKit
import NSObject_Rx
import Configs

open class BaseViewController: UIViewController, HasDisposeBag, HasScreenType {
        
    open var screenType: ScreenType! {
        return .none
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        bindDatas()
    }

    open func setupUI() {}

    open func bindDatas() {}

}
