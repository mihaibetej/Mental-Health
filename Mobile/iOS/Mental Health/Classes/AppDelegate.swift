//
//  AppDelegate.swift
//  Mental Health
//
//  Created by Mihai Betej on 27/03/2020.
//  Copyright © 2020 Mihai Betej. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Override point for customization after application launch.
        // Configure Firebase
        FirebaseApp.configure()
        
        // Customize UI
        UITabBar.appearance().tintColor = .mhBlue
        UINavigationBar.appearance().tintColor = .mhBlue
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.mhBlue]
        
        // Go go go...
        return true
    }

}

