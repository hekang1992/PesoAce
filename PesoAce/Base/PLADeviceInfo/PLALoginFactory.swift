//
//  PLALoginFactory.swift
//  PesoAce
//
//  Created by apple on 2024/8/4.
//

import UIKit
import DeviceKit

let PLA_LOGIN = "PLA_LOGIN"
let PLA_SESSIONID = "PLA_SESSIONID"

class PLALoginFactory: NSObject {

    static func getLoginParas() -> [String: String]{
        
        var remem: String = ""
        if let sessionId: String = UserDefaults.standard.object(forKey: PLA_SESSIONID) as? String {
            remem = sessionId
        }
        
        let dict1 = ["greatness": "iOS",
                    "powerless": getAppVersion(),
                    "obey": Device.current.description,
                     "muham": DeviceInfo.getIdfv(),
                     "justice": UIDevice.current.systemVersion,
                     "bered": "lucky",
                     "remem": remem]
        
        let dict2 = ["undulating": DeviceInfo.getIdfv(),
                     "boyfine": "1",
                     "apple": "ios",
                     "google": "and",
                     "amz": "1",
                     "type": "1",
                     "orange": "1"]
        
        let allDict = dict2.reduce(into: dict1) { (result, item) in
            result[item.key] = item.value
        }
        return allDict
    }
    
}


extension PLALoginFactory {
    
    
    static func getAppVersion() -> String {
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            return version
        }
        return "1.0.0"
    }
    
    static func saveLoginInfo(_ phone: String, _ sessionID: String) {
        UserDefaults.standard.setValue(phone, forKey: PLA_LOGIN)
        UserDefaults.standard.setValue(sessionID, forKey: PLA_SESSIONID)
        UserDefaults.standard.synchronize()
    }
    
    static func removeLoginInfo() {
        UserDefaults.standard.setValue("", forKey: PLA_LOGIN)
        UserDefaults.standard.setValue("", forKey: PLA_SESSIONID)
        UserDefaults.standard.synchronize()
    }
    
}
