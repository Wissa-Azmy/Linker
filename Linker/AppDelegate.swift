//
//  AppDelegate.swift
//  Linker
//
//  Created by Wissa Azmy on 8/3/19.
//  Copyright © 2019 Wissa Michael. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    let Deeplinker = DeepLinkManager()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        var shortcutItems = UIApplication.shared.shortcutItems ?? []
        if let existingShortcutItem = shortcutItems.first {
            
            guard let mutableShortcutItem = existingShortcutItem.mutableCopy() as? UIMutableApplicationShortcutItem else {
                preconditionFailure("Expected a UIMutableApplicationShortcutItem")
            }
            guard let index = shortcutItems.firstIndex(of: existingShortcutItem) else {
                preconditionFailure("Expected a valid index")
            }
            
            mutableShortcutItem.localizedTitle = "New Title"
            shortcutItems[index] = mutableShortcutItem
            UIApplication.shared.shortcutItems = shortcutItems
        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        
        // handle any deeplink
        Deeplinker.checkDeepLink()
        
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

// MARK: - Handle 3D touch Shortcuts
extension AppDelegate {
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        
        completionHandler(Deeplinker.handleShortcut(item: shortcutItem))
    }
}

