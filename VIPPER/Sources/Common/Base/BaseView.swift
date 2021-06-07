//
//  BaseView.swift
//  VIPPER
//
//  Created by Manh Pham on 06/06/2021.
//

import Foundation

protocol BaseView: AnyObject {
    func showAlert(title: String, message: String)
    func showLoading(isLoading: Bool)
}
