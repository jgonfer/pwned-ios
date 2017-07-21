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
    let navigator = Navigator()
    
    let testing = NSClassFromString("XCTest") != nil

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        BuddyBuildSDK.setup()
        
        if !testing {
            let feedNavigation = window!.rootViewController! as! UITabBarController
            navigator.show(segue: .listBreachesSearch(), sender: feedNavigation)
        }
        return true
    }
}
