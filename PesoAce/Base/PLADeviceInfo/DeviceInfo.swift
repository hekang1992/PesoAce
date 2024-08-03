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

let Key_Service = "Key_Service"

let Key_Account = "Key_Account"

// 宽度
let SCREEN_WIDTH = UIScreen.main.bounds.size.width
// 高度
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height


class DeviceInfo: NSObject {

    
    
    
    
    
    
}


extension DeviceInfo {
    
    static func getIdfv() -> String {
        if let uuid = SAMKeychain.password(forService: Key_Service, account: Key_Account), !uuid.isEmpty {
            return uuid
        } else {
            if let deviceIDFV = UIDevice.current.identifierForVendor?.uuidString {
                let success = SAMKeychain.setPassword(deviceIDFV, forService: Key_Service, account: Key_Account)
                if success {
                    print("获取的UUID is \(deviceIDFV)")
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
