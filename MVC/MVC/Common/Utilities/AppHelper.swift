//
//  AppHelper.swift
//  MVC
//
//  Created by Manh Pham on 3/2/21.
//

import UIKit

class AppHelper {
    
    static let shared = AppHelper()
    private init() {}
    
    func showAlert(title: String, message: String) {
        let vc = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        vc.addAction(action)
        UIWindow.shared?.rootViewController?.present(vc, animated: true)
    }
    
}
