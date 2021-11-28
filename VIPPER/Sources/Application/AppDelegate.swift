//
//  AppDelegate.swift
//  VIPER
//
//  Created by Manh Pham on 2/8/21.
//

import UIKit
@_exported import RxBinding

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    @LazyInjected var getLoginStatusUseCaseInterface: GETLoginStatusUseCaseInterface
    
    static var keyWindow: UIWindow? {
        return UIApplication.shared.windows.first(where: { $0.isKeyWindow })
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let vc = getLoginStatusUseCaseInterface.isLogin() ? AppScenes.main.viewController : AppScenes.login.viewController
        window?.rootViewController = UINavigationController(rootViewController: vc)
        window?.makeKeyAndVisible()

        LoggerSetup()
        LoadingHelper.shared.perform()
        
        return true
    }

}

