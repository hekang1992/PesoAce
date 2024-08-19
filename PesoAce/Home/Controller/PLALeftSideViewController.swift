//
//  PLALeftSideViewController.swift
//  PesoAce
//
//  Created by apple on 2024/8/5.
//

import UIKit
import TYAlertController

class PLALeftSideViewController: PLABaseViewController {
    
    lazy var leftView = PLALeftSideView()
    
    lazy var logoutView: PLAOutView = {
        let logoutView = PLAOutView(frame: self.view.bounds)
        return logoutView
    }()
    
    lazy var delView: PLAOutView = {
        let delView = PLAOutView(frame: self.view.bounds)
        delView.sureBtn.layer.borderColor = UIColor.init(css: "#F44444").cgColor
        delView.sureBtn.setTitleColor(UIColor.init(css: "#F44444"), for: .normal)
        delView.nameLabel.text = "Deleting an account"
        delView.nameLabel.textColor = UIColor.init(css: "#F44444")
        delView.nameLabel1.text = "Are you sure you want to delete this account? This action will permanently remove all your personal information, data records, and account settings, and they cannot be recovered. Please proceed with caution."
        return delView
    }()
    
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
        leftView.block1 = { [weak self] in
            let webVc = PLAWebViewController()
            if let requestUrl = JudgeConfig.createRequsetURL(baseURL: h5Url + "/takasaki", params: PLALoginFactory.getLoginParas()) {
                webVc.productUrl = requestUrl
            }
            self?.gy_sidePushViewController(viewController: webVc)
        }
        leftView.block2 = { [weak self] in
            self?.logOut()
        }
        leftView.block3 = { [weak self] in
            let orderVc = PLAOrderViewController()
            self?.gy_sidePushViewController(viewController: orderVc)
        }
        leftView.block4 = { [weak self] in
            let webVc = PLAWebViewController()
            if let requestUrl = JudgeConfig.createRequsetURL(baseURL: h5Url + "/getting", params: PLALoginFactory.getLoginParas()) {
                webVc.productUrl = requestUrl
            }
            self?.gy_sidePushViewController(viewController: webVc)
        }
        leftView.block5 = { [weak self] in
            let webVc = PLAWebViewController()
            if let requestUrl = JudgeConfig.createRequsetURL(baseURL: h5Url + "/sweetheart", params: PLALoginFactory.getLoginParas()) {
                webVc.productUrl = requestUrl
            }
            self?.gy_sidePushViewController(viewController: webVc)
        }
        leftView.block6 = { [weak self] in
            self?.delOut()
        }
        leftView.block7 = { [weak self] in
            let bankVc = PLAChangeBankViewController()
            self?.gy_sidePushViewController(viewController: bankVc)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}


extension PLALeftSideViewController {
    
    
    func logOut() {
        let alertVc = TYAlertController(alert: logoutView, preferredStyle: .alert,
                                        transitionAnimation: .fade)
        self.present(alertVc!, animated: true)
        logoutView.block1 = { [weak self] in
            self?.logAit()
        }
        logoutView.block2 = { [weak self] in
            self?.dismiss(animated: true)
        }
    }
    
    func delOut() {
        delView.bgView.snp.updateConstraints { make in
            make.height.equalTo(270.px())
        }
        let alertVc = TYAlertController(alert: delView, preferredStyle: .alert, transitionAnimation: .fade)
        self.present(alertVc!, animated: true)
        delView.block1 = { [weak self] in
            self?.delAit()
        }
        delView.block2 = { [weak self] in
            self?.dismiss(animated: true)
        }
    }
    
    func logAit() {
        ViewHud.addLoadView()
        PLAAFNetWorkManager.shared.requestAPI(params: ["logout": "1", "islogin": "0"], pageUrl: "/ace/wetness/monkey/clear", method: .get) { [weak self ] baseModel in
            ViewHud.hideLoadView()
            if baseModel.greasy == 0 || baseModel.greasy == 00 {
                self?.dismiss(animated: true, completion: {
                    PLALoginFactory.removeLoginInfo()
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue:"GYSideTapNotification"), object: nil)
                })
            }
        } errorBlock: { error in
            ViewHud.hideLoadView()
        }
    }
    
    func delAit() {
        ViewHud.addLoadView()
        PLAAFNetWorkManager.shared.requestAPI(params: ["delout": "1", "sureDel": "1"], pageUrl: "/ace/would/shoot/voice", method: .get) { [weak self] baseModel in
            ViewHud.hideLoadView()
            if baseModel.greasy == 0 || baseModel.greasy == 00 {
                self?.dismiss(animated: true, completion: {
                    PLALoginFactory.removeLoginInfo()
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue:"GYSideTapNotification"), object: nil)
                })
            }
        } errorBlock: { error in
            ViewHud.addLoadView()
        }
    }
    
}
