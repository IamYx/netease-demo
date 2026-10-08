//
//  AppDelegate.swift
//  NIMSDKSwift
//
//  Created by 姚肖 on 2023/4/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    public var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .sound, .alert]) { isSuccess, error in
            print("isSuccess: \(isSuccess), error: \(error)")
            if isSuccess {
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle
    // iOS 26/27 SDK 起 App 必须走 UIScene 生命周期，这里返回与 Info.plist 中
    // UIApplicationSceneManifest 对应的 Scene 配置。
    func application(_ application: UIApplication,
                     configurationForConnecting connectingSceneSession: UISceneSession,
                     options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }

}

func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
    print("register remote notification failed: \(error)")
}

func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    let tokenString = deviceToken.reduce(into: "") { $0 += String(format: "%02X", $1) }
    print("device token is: \(tokenString)")
}

