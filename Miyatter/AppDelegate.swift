//
//  AppDelegate.swift
//  Miyatter
//
//  Created by miyasaka on 2017/04/22.
//  Copyright © 2017年 miyacc. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]? = nil) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: TimeLineViewController())
        window?.makeKeyAndVisible()
        return true
    }
}

