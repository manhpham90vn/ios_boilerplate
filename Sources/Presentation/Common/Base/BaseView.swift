//
//  BaseView.swift
//  VIPPER
//
//  Created by Manh Pham on 06/06/2021.
//

import RxSwift

protocol BaseView: AnyObject {
    func showAlert(title: String, message: String, completion: (() -> Void)?)
    func showAlertRx(title: String, message: String) -> Single<Void>
}

extension BaseView {
    func showAlert(title: String, message: String, completion: (() -> Void)? = nil) {
        AppHelper.shared.showAlert(title: title, message: message, completion: completion)
    }
    func showAlertRx(title: String, message: String) -> Single<Void> {
        AppHelper.shared.showAlertRx(title: title, message: message)
    }
}
