//
//  NetInfoManager.swift
//  PesoAce
//
//  Created by apple on 2024/8/3.
//

import Alamofire
import Reachability

class NetInfoManager {

    enum NetworkStatus {
        case none
        case wifi
        case cellular
    }
    
    typealias NetworkStatusHandler = (NetworkStatus) -> Void
    
    var typeSty: String = "none"
    
    static let shared = NetInfoManager()
    
    private let reachability = try!Reachability()
    
    private var networkStatusHandler: NetworkStatusHandler?
    
    init() {
        setupReachability()
    }
    
    private func setupReachability() {
        NotificationCenter.default.addObserver(self, selector: #selector(networkStatusChanged), name: .reachabilityChanged, object: reachability)
        do {
            try reachability.startNotifier()
        } catch {
            print("noway")
        }
    }
    
    deinit {
        reachability.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: nil)
    }
    
    @objc func networkStatusChanged() {
        if reachability.connection != .unavailable {
            if reachability.connection == .wifi {
                typeSty = "WIFI"
                notifyNetworkStatus(.wifi)
            } else {
                typeSty = "4G/5G"
                notifyNetworkStatus(.cellular)
            }
        } else {
            typeSty = "NONE"
            notifyNetworkStatus(.none)
        }
    }
    
    func observeNetworkStatus(_ handler: @escaping NetworkStatusHandler) {
        networkStatusHandler = handler
    }
    
    private func notifyNetworkStatus(_ status: NetworkStatus) {
        if status == .none {
            networkStatusHandler?(status)
        }else {
            reachability.stopNotifier()
            NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: nil)
            networkStatusHandler?(status)
        }
    }
    
}
