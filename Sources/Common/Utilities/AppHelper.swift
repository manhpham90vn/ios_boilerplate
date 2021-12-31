//
//  AppHelper.swift
//  VIPER
//
//  Created by Manh Pham on 3/2/21.
//

import UIKit

final class AppHelper {
    
    static let shared = AppHelper()
    
    private init() {}
    
    @Atomic var isShowAlert = false
    
    func showAlert(title: String, message: String, completion: (() -> Void)? = nil) {
        let vc = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Chấp Nhận", style: .cancel) { _ in
            completion?()
        }
        vc.addAction(action)
        UIWindow.shared?.rootViewController?.present(vc, animated: true)
    }
    
    func showAlertRx(title: String?, message: String?, cancel: String? = "Huỷ", ok: String? = "Chấp Nhận") -> Observable<Void> {
        guard !isShowAlert else { return .empty() }
        return Observable<Void>.create { [weak self] observer in
            guard let self = self else { return Disposables.create() }
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(.init(title: cancel, style: .cancel, handler: { [weak self] _ in
                self?.isShowAlert = false
                observer.onCompleted()
            }))
            alert.addAction(.init(title: ok, style: .default, handler: { [weak self] _ in
                self?.isShowAlert = false
                observer.onNext(())
                observer.onCompleted()
            }))
            self.isShowAlert = true
            AppHelper.shared.topViewController()?.present(alert, animated: true, completion: nil)
            return Disposables.create {
                alert.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func topViewController(_ viewController: UIViewController? = UIWindow.shared?.rootViewController) -> UIViewController? {
        if let nav = viewController as? UINavigationController {
            return topViewController(nav.visibleViewController)
        }
        if let tab = viewController as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(selected)
            }
        }
        if let presented = viewController?.presentedViewController {
            return topViewController(presented)
        }
        return viewController
    }
    
}
