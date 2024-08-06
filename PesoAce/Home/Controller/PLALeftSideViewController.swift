//
//  PLALeftSideViewController.swift
//  PesoAce
//
//  Created by apple on 2024/8/5.
//

import UIKit

class PLALeftSideViewController: PLABaseViewController {
    
    lazy var leftView = PLALeftSideView()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(leftView)
        leftView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        leftView.block = {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue:"GYSideTapNotification"), object: nil)
        }
        leftView.block1 = {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue:"GYSideTapNotification"), object: nil)
        }
        leftView.block2 = {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue:"GYSideTapNotification"), object: nil)
        }
        leftView.block3 = { [weak self] in
            let orderVc = PLAOrderViewController()
            self?.gy_sidePushViewController(viewController: orderVc)
        }
        leftView.block4 = {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue:"GYSideTapNotification"), object: nil)
        }
        leftView.block5 = {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue:"GYSideTapNotification"), object: nil)
        }
        leftView.block6 = {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue:"GYSideTapNotification"), object: nil)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}
