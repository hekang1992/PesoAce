//
//  AppDelegate.swift
//  PesoAce
//
//  Created by apple on 2024/8/3.
//

import UIKit
import IQKeyboardManagerSwift
import AppTrackingTransparency

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
        NotificationCenter.default.addObserver(self, selector: #selector(setlOAcationInfo(_ :)), name: NSNotification.Name(LOCATION_INFO), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(idfaInfo(_ :)), name: NSNotification.Name(IDFA_INFO), object: nil)
    }
    
    @objc func idfaInfo(_ notification: Notification) {
        if #available(iOS 14.0, *) {
            ATTrackingManager.requestTrackingAuthorization { status in
                switch status {
                case .authorized:
                    print("Tracking authorized")
                    self.upidfa()
                    break
                case .denied:
                    self.upidfa()
                    print("Tracking denied")
                    break
                case .notDetermined:
                    self.upidfa()
                    print("Tracking not determined")
                    break
                case .restricted:
                    print("Tracking restricted")
                    break
                @unknown default:
                    print("Unknown status")
                    break
                }
            }
        }
    }
    
    @objc func setlOAcationInfo(_ notification: Notification) {
        PLALocation.shared.startUpdatingLocation { locationModel in
            PLAAFNetWorkManager.shared.requestAPI(params: [
                "scratched": locationModel.scratched,
                "punched": locationModel.punched,
                "align": locationModel.align,
                "noticing": locationModel.noticing,
                "ome": locationModel.ome,
                "grasping": locationModel.grasping,
                "slamming": locationModel.slamming,
                "sinbad": "ph",
                "swordfight": "sig"], pageUrl: "/ace/mouth/delayed/sprawling", method: .post) { baseModel in
                
            } errorBlock: { error in
                
            }

        }
    }
    
    @objc func setUpRootVc(_ notification: Notification) {
        if IS_LOGIN {
            window?.rootViewController = PLANavigationController(rootViewController: PLAHomeViewController())
        }else {
            window?.rootViewController = PLANavigationController(rootViewController: PLALoginViewController())
        }
    }
    
    func upidfa() {
        PLAAFNetWorkManager.shared.requestAPI(params: ["mauve": "apple", "brushing": DeviceInfo.getIDFV(), "flossing": DeviceInfo.getIDFA(), "islogin": "0"], pageUrl: "/ace/business/rahim/shiny", method: .post) { baseModel in
            
        } errorBlock: { error in
            
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
