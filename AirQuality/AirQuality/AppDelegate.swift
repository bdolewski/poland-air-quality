//
//  AppDelegate.swift
//  AirQuality
//
//  Created by Bartosz Dolewski on 06/01/2019.
//  Copyright © 2019 Bartosz Dolewski. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let appCoordinator = AppCoordinator(window: self.window)
        appCoordinator.start()
        
        return true
    }
}

