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
    @LazyInjected var authManager: AuthManagerInterface
    
    static var keyWindow: UIWindow? {
        return UIApplication.shared.windows.first(where: { $0.isKeyWindow })
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        if #available(iOS 13, *) {
            
        } else {
            window = UIWindow(frame: UIScreen.main.bounds)
            let vc = authManager.isLogin ? AppScenes.main.viewController : AppScenes.login.viewController
            window?.rootViewController = UINavigationController(rootViewController: vc)
            window?.makeKeyAndVisible()
        }

        LoggerSetup()
        return true
    }

    // MARK: UISceneSession Lifecycle
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

}

