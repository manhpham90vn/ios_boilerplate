//
//  AppDelegate.swift
//  VIPER
//
//  Created by Manh Pham on 2/8/21.
//

import UIKit
import FirebaseCrashlytics
import FirebaseAnalytics
import FirebaseCore
import FirebaseMessaging
import MPInjector
import Logs

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    @Inject var local: LocalStorageRepository
    @Inject var loading: LoadingHelper
    @Inject var permission: PermissionManager
        
    static var keyWindow: UIWindow? {
        return UIApplication.shared.windows.first(where: { $0.isKeyWindow })
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let vc = local.getLoginState() == .logined ? AppScenes.main.viewController : AppScenes.login.viewController
        window?.rootViewController = UINavigationController(rootViewController: vc)
        window?.makeKeyAndVisible()

        // config service
        Logger.shared.setUpLog()
        loading.perform()
        FirebaseApp.configure()

        configApplePush(application)

        return true
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let deviceTokenString = deviceToken.map { String(format: "%02x", $0) }.joined()
        LogInfo("DeviceToken \(deviceTokenString)")
        Messaging.messaging().apnsToken = deviceToken
    }
    
    // silent push
    // real device
    func application(_ application: UIApplication,
                     didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // perfrom api call here
        completionHandler(.newData)
    }

    // silent push
    // simulator
    func application(_ application: UIApplication,
                     performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // perfrom api call here
        completionHandler(.newData)
    }
}

extension AppDelegate {

    func configApplePush(_ application: UIApplication) {
        // config delegate
        UNUserNotificationCenter.current().delegate = self
        Messaging.messaging().delegate = self
        
        // request push
        permission.request(type: .requestPush, application: application)
    }

}

extension AppDelegate: UNUserNotificationCenterDelegate {
    // forceground call when when receive push
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound])
    }

    // forceground call tap to push
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }

}

extension AppDelegate: MessagingDelegate {
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {

        guard let fcmToken = fcmToken else { return }

        LogInfo("fcmToken \(fcmToken)")
    }

}
