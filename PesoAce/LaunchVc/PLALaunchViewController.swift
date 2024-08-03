//
//  PLALaunchViewController.swift
//  PesoAce
//
//  Created by apple on 2024/8/3.
//

import UIKit

class PLALaunchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        panduanWangLuoWork()
        view.backgroundColor = .white
    }
}

extension PLALaunchViewController {
    func panduanWangLuoWork() {
        NetInfoManager.shared.observeNetworkStatus { status in
            switch status {
            case .none:
                print("无网络连接")
                break
            case .wifi:
                print("网络>>>>>>>WIFI")
                break
            case .cellular:
                print("网络>>>>>>>4G/5G")
                break
            }
        }
    }
    
}
