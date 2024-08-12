//
//  DeviceInfo.swift
//  PesoAce
//
//  Created by apple on 2024/8/3.
//

import UIKit
import SAMKeychain
import AdSupport
import SystemConfiguration
import SystemServices
import SystemConfiguration.CaptiveNetwork
import DeviceKit

let Key_Service = "Key_Service"
let Key_Account = "Key_Account"
let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height

class DeviceInfo: NSObject {
    
    static func getDeviceInfo() -> [String: Any] {
        
        var dict: [String: Any] = ["sneeze": "iOS",
                                   "stretches": SystemServices().systemsVersion ?? "",
                                   "vivid": getLoginTime(),
                                   "amazingly": Bundle.main.bundleIdentifier ?? ""]
        
        dict["devoted"] = ["soap": SystemServices().batteryLevel,
                           "actor": SystemServices().charging ? 1 : 0]
        
        dict["gel"] = ["brushing": getIDFV(),
                       "flossing": getIDFA(),
                       "lessons": getCurrentWifiMac(),
                       "sweetened": getCurrentTime(),
                       "backed": isUsingProxy(),
                       "bravery": isVPNConnected(),
                       "goshkhor": isJailBreak(),
                       "is_simulator": Device.current.isSimulator ? "1" : "0",
                       "sling": SystemServices().language ?? "",
                       "overthrew": SystemServices().carrierName ?? "",
                       "laced": NetInfoManager.shared.typeSty,
                       "disgusting": NSTimeZone.system.abbreviation() ?? "",
                       "coy": timeSinceDeviceBoot()]
        
        dict["earlobe"] = ["pinched": "",
                           "slicing": Device.current.name ?? "",
                           "apply":"",
                           "slaughter": ScreenHeight(),
                           "cleansing": UIDevice.current.name,
                           "traitors": ScreenWidth(),
                           "snickering": Device.current.description,
                           "enjoyable": String(Device.current.diagonal),
                           "leash": Device.current.systemVersion ?? ""]
        
        let wifiInfo: [String: Any] = ["asthma": getAppWifiSSIDInfo(),
                                       "stoning": getAppWifiBSSIDInfo(),
                                       "lessons": getCurrentWifiMac(),
                                       "shrapnel": getAppWifiSSIDInfo()]
        
        
        dict["unexpectedly"] = ["raping": SSNetworkInfo.currentIPAddress() ?? "",
                                "funny": "0",
                                "meymanah": wifiInfo]
        
        dict["battlefield"] = ["imaginable": freeDisk(),
                               "kidney": allDisk(),
                               "peeing": totalMemory(),
                               "prisoners": activeMemoryinRaw()]
        
        return dict
    }
    
}

extension DeviceInfo {
    
    static func timeSinceDeviceBoot() -> String {
        let systemUptime = ProcessInfo.processInfo.systemUptime
        return String(format: "%.0f", systemUptime * 1000)
    }
    
    static func getCurrentTime() -> String {
        let currentTime = Date().timeIntervalSince1970
        let currentTimeMillis = String(Int64(currentTime * 1000))
        return currentTimeMillis
    }
    
    static func getLoginTime() -> String {
        let loginTime: TimeInterval = ProcessInfo.processInfo.systemUptime
        let timeDate = Date(timeIntervalSinceNow: 0 - loginTime)
        let timeSp = String(format: "%ld", Int(timeDate.timeIntervalSince1970 * 1000))
        return timeSp
    }
    
    static func getIDFV() -> String {
        if let uuid = SAMKeychain.password(forService: Key_Service, account: Key_Account), !uuid.isEmpty {
            return uuid
        } else {
            if let deviceIDFV = UIDevice.current.identifierForVendor?.uuidString {
                let success = SAMKeychain.setPassword(deviceIDFV, forService: Key_Service, account: Key_Account)
                if success {
                    return deviceIDFV
                } else {
                    return ""
                }
            } else {
                return ""
            }
        }
    }
    
    static func getIDFA() -> String {
        let idfa = ASIdentifierManager.shared().advertisingIdentifier
        return idfa.uuidString
    }
    
    static func isUsingProxy() -> String {
        if let proxySettings = CFNetworkCopySystemProxySettings()?.takeRetainedValue() as? [AnyHashable: Any],
           let proxies = CFNetworkCopyProxiesForURL(URL(string: "https://www.apple.com")! as CFURL, proxySettings as CFDictionary).takeRetainedValue() as? [Any],
           let settings = proxies.first as? [AnyHashable: Any],
           let proxyType = settings[kCFProxyTypeKey] as? String {
            if proxyType == kCFProxyTypeNone as String {
                return "0"
            } else {
                return "1"
            }
        }
        return "0"
    }
    
    static func isVPNConnected() -> Bool {
        var zeroAddress = sockaddr()
        zeroAddress.sa_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sa_family = sa_family_t(AF_INET)
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }) else {
            return false
        }
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        return isReachable && !needsConnection
    }
    
    static func ScreenWidth() -> String {
        let width = String(format: "%.0f",SCREEN_WIDTH)
        return width
    }
    
    static func ScreenHeight() -> String {
        let height = String(format: "%.0f",SCREEN_HEIGHT)
        return height
    }
    
    static func freeDisk() -> String {
        let freeDisk = String(format: "%.2lld", SystemServices.shared().longFreeDiskSpace)
        return freeDisk
    }
    
    static func allDisk() -> String {
        let allDisk = String(format: "%.2lld", SystemServices.shared().longDiskSpace)
        return allDisk
    }
    
    static func totalMemory() -> String {
        let totalMemory = String(format: "%.0f", SystemServices.shared().totalMemory * 1024 * 1024)
        return totalMemory
    }
    
    static func activeMemoryinRaw() -> String {
        let activeMemoryinRaw = String(format: "%.0f", SystemServices.shared().activeMemoryinRaw * 1024 * 1024)
        return activeMemoryinRaw
    }
    
    static func isJailBreak() -> String {
        let jailbreakToolPaths = [
            "/Applications/Cydia.app",
            "/Library/MobileSubstrate/MobileSubstrate.dylib",
            "/bin/bash",
            "/usr/sbin/sshd",
            "/etc/apt"
        ]
        for path in jailbreakToolPaths {
            if FileManager.default.fileExists(atPath: path) {
                return "1"
            }
        }
        return "0"
    }
    
    static func getCurrentWifiMac() -> String {
        guard let interfaces = CNCopySupportedInterfaces() as? [String] else {
            return ""
        }
        for interface in interfaces {
            guard let info = CNCopyCurrentNetworkInfo(interface as CFString) as NSDictionary? else {
                continue
            }
            if let bssid = info[kCNNetworkInfoKeyBSSID as String] as? String {
                return bssid
            }
        }
        return ""
    }
    
    static  func getAppWifiSSIDInfo() -> String {
        var currentSSID = ""
        if let myArray = CNCopySupportedInterfaces() as? [String],
           let interface = myArray.first as CFString?,
           let myDict = CNCopyCurrentNetworkInfo(interface) as NSDictionary? {
            currentSSID = myDict["SSID"] as? String ?? ""
        } else {
            currentSSID = ""
        }
        return currentSSID
    }
    
    static  func getAppWifiBSSIDInfo() -> String {
        var currentSSID = ""
        if let myArray = CNCopySupportedInterfaces() as? [String],
           let interface = myArray.first as CFString?,
           let myDict = CNCopyCurrentNetworkInfo(interface) as NSDictionary? {
            currentSSID = myDict["BSSID"] as? String ?? ""
        } else {
            currentSSID = ""
        }
        return currentSSID
    }
    
}
