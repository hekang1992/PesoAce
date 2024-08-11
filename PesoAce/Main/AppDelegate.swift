//
//  AppDelegate.swift
//  PesoAce
//
//  Created by apple on 2024/8/3.
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        jianPanManager()
        rootVcPush()
        window?.rootViewController = PLANavigationController(rootViewController: PLALaunchViewController())
        window?.makeKeyAndVisible()
        return true
    }
}

extension AppDelegate {
    
    func jianPanManager(){
        let manager = IQKeyboardManager.shared
        manager.shouldResignOnTouchOutside = true
        manager.enable = true
    }
    
    func rootVcPush() {
        NotificationCenter.default.addObserver(self, selector: #selector(setUpRootVc(_ :)), name: NSNotification.Name(ROOT_VC), object: nil)
    }
    
    @objc func setUpRootVc(_ notification: Notification) {
        if IS_LOGIN {
            window?.rootViewController = PLANavigationController(rootViewController: PLAHomeViewController())
        }else {
            window?.rootViewController = PLANavigationController(rootViewController: PLALoginViewController())
        }
    }
    
    func getFontNames() {
        let familyNames = UIFont.familyNames
        for familyName in familyNames {
            let fontNames = UIFont.fontNames(forFamilyName: familyName)
            for fontName in fontNames {
                print("fontName>>>>>>>>>>>>>>\(fontName)")
            }
        }
    }
    
}
