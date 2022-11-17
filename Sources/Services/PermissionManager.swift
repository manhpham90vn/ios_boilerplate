//
//  PermissionManager.swift
//  MyApp
//
//  Created by Manh Pham on 17/11/2022.
//

import Foundation
import UIKit

enum PermissionType {
    case requestPush
}

enum PermissionResult {
    case success
}

class PermissionManager {
    func request(type: PermissionType, application: UIApplication) {
        switch type {
        case .requestPush:
            requestPush(application: application)
        }
    }
    
    private func requestPush(application: UIApplication) {
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { granted, _ in
            if granted {
                DispatchQueue.main.async {
                    application.registerForRemoteNotifications()
                }
            }
        }
    }
}
