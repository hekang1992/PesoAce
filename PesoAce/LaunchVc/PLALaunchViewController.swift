//
//  PLALaunchViewController.swift
//  PesoAce
//
//  Created by apple on 2024/8/3.
//

import UIKit
import SnapKit

let ROOT_VC = "ROOT_VC"

let LOCATION_INFO = "LOCATION_INFO"

class PLALaunchViewController: PLABaseViewController {
    
    lazy var gbImageView: UIImageView = {
        let gbImageView = UIImageView()
        gbImageView.contentMode = .scaleAspectFill
        gbImageView.image = UIImage(named: "launch")
        return gbImageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.addSubview(gbImageView)
        gbImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        panduanWangLuoWork()
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
                print(">>>>>>>WIFI")
                NotificationCenter.default.post(name: NSNotification.Name(ROOT_VC), object: nil)
                break
            case .cellular:
                NotificationCenter.default.post(name: NSNotification.Name(ROOT_VC), object: nil)
                print(">>>>>>>4G/5G")
                break
            }
        }
    }
    
}
