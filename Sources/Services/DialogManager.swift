//
//  DialogManager.swift
//  MyApp
//
//  Created by Manh Pham on 16/11/2022.
//

import Foundation
import UIKit
import MPInjector

enum TypeDialog {
    case closeDialog
    case retryDialog
}

class DialogManager {
    @Inject var appHelper: AppHelper
    
    @Atomic var isShowedDialog = false
    
    func showDialog(typeDialog: TypeDialog,
                    title: String? = nil,
                    message: String? = nil,
                    retryButtonLabel: String? = nil,
                    closeButtonLabel: String? = nil,
                    callbackRetry: (() -> Void)? = nil,
                    callbackClose: (() -> Void)? = nil) {
        if isShowedDialog {
            return
        }
        isShowedDialog = true
        
        switch typeDialog {
        case .closeDialog:
            createCloseDialog(title: title,
                              message: message,
                              closeButtonLabel: closeButtonLabel,
                              callbackClose: callbackClose)
        case .retryDialog:
            createRetryDialog(title: title,
                              message: message,
                              retryButtonLabel: retryButtonLabel,
                              closeButtonLabel: closeButtonLabel,
                              callbackRetry: callbackRetry,
                              callbackClose: callbackClose)
        }
    }
    
    private func createCloseDialog(title: String? = nil,
                                   message: String? = nil,
                                   closeButtonLabel: String? = nil,
                                   callbackClose: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: closeButtonLabel ?? "OK", style: .cancel, handler: { _ in callbackClose?() })
        alert.addAction(cancelAction)
        
        appHelper.topViewController()?.present(alert, animated: true, completion: { [weak self] in
            self?.isShowedDialog = false
        })
    }
    
    private func createRetryDialog(title: String? = nil,
                                   message: String? = nil,
                                   retryButtonLabel: String? = nil,
                                   closeButtonLabel: String? = nil,
                                   callbackRetry: (() -> Void)? = nil,
                                   callbackClose: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: retryButtonLabel ?? "Retry", style: .default, handler: { _ in callbackRetry?() })
        alert.addAction(okAction)
        
        let cancelAction = UIAlertAction(title: closeButtonLabel ?? "Close", style: .cancel, handler: { _ in callbackClose?() })
        alert.addAction(cancelAction)
        
        appHelper.topViewController()?.present(alert, animated: true, completion: { [weak self] in
            self?.isShowedDialog = false
        })
    }
}
