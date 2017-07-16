//
//  AppDelegate.swift
//  pwned
//
//  Created by Josep Gonzalez Fernandez on 13/7/17.
//  Copyright © 2017 Dreams Corner. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        BuddyBuildSDK.setup()
        
        // Override point for customization after application launch.
        return true
    }
}
