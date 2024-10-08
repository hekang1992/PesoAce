//
//  PLALaunchViewController.swift
//  PesoAce
//
//  Created by apple on 2024/8/3.
//

import UIKit
import SnapKit

let ROOT_VC = "ROOT_VC"

let SHANGCHUAN_VC = "SHANGCHUAN_VC"

let LOCATION_INFO = "LOCATION_INFO"

let IDFA_INFO = "IDFA_INFO"

class PLALaunchViewController: PLABaseViewController {
    
    lazy var gbImageView: UIImageView = {
        let gbImageView = UIImageView()
        gbImageView.contentMode = .scaleAspectFill
        gbImageView.image = UIImage(named: "launch")
        return gbImageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(gbImageView)
        gbImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        panduanWangLuoWork()
    }
}

extension PLALaunchViewController {
    func panduanWangLuoWork() {
        NetInfoManager.shared.observeNetworkStatus { [weak self] status in
            switch status {
            case .none:
                print(">>>>>>>>no net")
                break
            case .wifi:
                print(">>>>>>>WIFI")
                self?.rootAvc()
                break
            case .cellular:
                self?.rootAvc()
                print(">>>>>>>4G/5G")
                break
            }
        }
    }
    
    func rootAvc() {
        NotificationCenter.default.post(name: NSNotification.Name(ROOT_VC), object: nil)
        if IS_LOGIN {
            NotificationCenter.default.post(name: NSNotification.Name(LOCATION_INFO), object: nil)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            NotificationCenter.default.post(name: NSNotification.Name(IDFA_INFO), object: nil)
        }
    }
}
