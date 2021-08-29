//
//  BaseViewController.swift
//  VIPPER
//
//  Created by Manh Pham on 3/5/21.
//

import UIKit

class BaseViewController: UIViewController, HasDisposeBag { // swiftlint:disable:this final_class
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        bindDatas()
    }

    func setupUI() {}

    func bindDatas() {}

}
