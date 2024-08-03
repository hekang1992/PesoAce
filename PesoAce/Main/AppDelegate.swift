//
//  AppDelegate.swift
//  PesoAce
//
//  Created by apple on 2024/8/3.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.rootViewController = PLANavigationController(rootViewController: PLALaunchViewController())
        window?.makeKeyAndVisible()
        return true
    }


}

