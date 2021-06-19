//
//  BaseViewController.swift
//  VIPPER
//
//  Created by Manh Pham on 3/5/21.
//

import UIKit
import PKHUD

class BaseViewController: UIViewController, HasDisposeBag { // swiftlint:disable:this final_class

    let isLoading = PublishRelay<Bool>()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        bindViewModel()
    }

    func setupUI() {

    }

    func bindViewModel() {
        isLoading ~> PKHUD.rx.isAnimating ~ disposeBag
    }

}
