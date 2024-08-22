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
        DispatchQueue.main.async {
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
    }
    
    @objc func setlOAcationInfo(_ notification: Notification) {
        shangchuanweixinxinxi()
    }
    
    func shangchuanweixinxinxi() {
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
                "swordfight": "sig"], pageUrl: "/ace/mouth/delayed/sprawling", method: .post) { [weak self] baseModel in
                    self?.maidain1(locationModel)
                    self?.shebeixinxi()
                } errorBlock: { error in
                    
                }
        }
    }
    
    func shebeixinxi() {
        let dict = DeviceInfo.getDeviceInfo()
        if let base64String = dictToBaseStr(dict) {
            PLAAFNetWorkManager.shared.requestAPI(params: ["dowun": "1", "wallpaper": base64String], pageUrl: "/ace/placed/reached/small", method: .post) { baseModel in
                
            } errorBlock: { error in
                
            }
            
        }
    }
    
    func dictToBaseStr(_ dict: [String: Any]) -> String? {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dict)
            let base64EncodedString = jsonData.base64EncodedString()
            return base64EncodedString
        } catch {
            print(">>>>>>\(error)")
            return nil
        }
    }
    
    func maidain1(_ locationModel: LocationPModel) {
        let mai = UserDefaults.standard.object(forKey: MAIDIAN1) as? String ?? ""
        if mai != "1" {
            PLAAFNetWorkManager.shared.requestAPI(params: ["login_apple": "1", "peck": "", "jabbing": "1", "nail": DeviceInfo.getIDFV(), "warmed": DeviceInfo.getIDFA(), "grasping": locationModel.grasping, "ome": locationModel.ome, "clarity": DeviceInfo.getCurrentTime(), "curls": DeviceInfo.getCurrentTime(), "shining": "1"], pageUrl: "/ace/maplenow/margins/lovemaking", method: .post) { baseModel in
                UserDefaults.standard.setValue("1", forKey: MAIDIAN1)
                UserDefaults.standard.synchronize()
            } errorBlock: { error in
                
            }
        }
    }
    
    func upidfa() {
        PLAAFNetWorkManager.shared.requestAPI(params: ["mauve": "apple", "brushing": DeviceInfo.getIDFV(), "flossing": DeviceInfo.getIDFA(), "islogin": "0"], pageUrl: "/ace/business/rahim/shiny", method: .post) { baseModel in
            
        } errorBlock: { error in
            
        }
        
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
