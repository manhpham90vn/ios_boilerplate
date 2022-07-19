//
//  AppDelegate.swift
//  VIPER
//
//  Created by Manh Pham on 2/8/21.
//

import UIKit
import Resolver
import FirebaseCrashlytics
import FirebaseAnalytics
import FirebaseCore

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    @LazyInjected var local: LocalStorageRepository
    
    static var keyWindow: UIWindow? {
        return UIApplication.shared.windows.first(where: { $0.isKeyWindow })
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let vc = local.getLoginState() == .logined ? AppScenes.main.viewController : AppScenes.login.viewController
        window?.rootViewController = UINavigationController(rootViewController: vc)
        window?.makeKeyAndVisible()

        LoggerSetup()
        LoadingHelper.shared.perform()
        
        return true
    }

}

