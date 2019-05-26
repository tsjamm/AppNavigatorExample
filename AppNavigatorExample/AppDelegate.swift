//
//  AppDelegate.swift
//  AppNavigatorExample
//
//  Created by Sai Teja on 5/26/19.
//  Copyright © 2019 Sai Teja. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        AppNavigator.initialize(with: self)
        return true
    }
    
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        AppNavigator.navigate(basedOn: url, with: self)
        return true
    }
}

