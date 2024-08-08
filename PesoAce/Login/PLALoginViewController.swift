//
//  PLALoginViewController.swift
//  PesoAce
//
//  Created by apple on 2024/8/4.
//

import UIKit
import HandyJSON
import MBProgressHUD_WJExtension

class PLALoginViewController: PLABaseViewController {
    
    var totalTime = 60
    
    var phoneStr: String = ""
    
    var countTimer: Timer!
    
    lazy var loginView: PLALoginView = {
        let loginView = PLALoginView()
        return loginView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.addSubview(loginView)
        loginView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        loginView.block = { [weak self] btn in
            self?.codeClick(btn)
        }
        loginView.block1 = { [weak self]  in
            self?.loginInfo()
        }
        loginView.xieyiblock = { [weak self]  in
            MBProgressHUD.wj_showPlainText("协议", view: nil)
        }
    }
    
    
}

extension PLALoginViewController {
    
    func codeClick(_ btn: UIButton) {
        ViewHud.addLoadView()
        let phoneDict = ["troubling": self.loginView.phoneTx.text ?? "", "sighing": "0"]
        PLAAFNetWorkManager.shared.requestAPI(params: phoneDict, pageUrl: "/ace/before/harder/tournament", method: .post) { [weak self] baseModel in
            ViewHud.hideLoadView()
            let formica = baseModel.formica ?? ""
            if let greasy = baseModel.greasy, greasy == 0 || greasy == 00 {
                self?.startCode()
            }
            MBProgressHUD.wj_showPlainText(formica, view: nil)
        } errorBlock: { error in
            ViewHud.hideLoadView()
        }
    }
    
    func startCode() {
        self.loginView.sendBtn.isEnabled = false
        countTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    @objc func updateTime() {
        if totalTime > 0 {
            totalTime -= 1
            self.loginView.sendBtn.setTitle("Resend (\(self.totalTime)s)", for: .normal)
        } else {
            endTimer()
        }
    }
    
    func endTimer() {
        countTimer.invalidate()
        self.loginView.sendBtn.isEnabled = true
        self.loginView.sendBtn.setTitle("Resend", for: .normal)
        totalTime = 60
    }
    
    func loginInfo() {
        ViewHud.addLoadView()
        let logDict = ["lurch": loginView.phoneTx.text ?? "", "twilight": loginView.codeTx.text ?? "", "rip": "1"]
        PLAAFNetWorkManager.shared.requestAPI(params: logDict, pageUrl: "/ace/worthy/bamiyan/after", method: .post) { baseModel in
            ViewHud.hideLoadView()
            let formica = baseModel.formica ?? ""
            if let greasy = baseModel.greasy, greasy == 0 || greasy == 00 {
                guard let model = JSONDeserializer<wallpaperModel>.deserializeFrom(dict: baseModel.wallpaper) else { return }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                    PLALoginFactory.saveLoginInfo(model.lurch ?? "", model.remem ?? "")
                    NotificationCenter.default.post(name: NSNotification.Name(ROOT_VC), object: nil)
                }
            }
            MBProgressHUD.wj_showPlainText(formica, view: nil)
        } errorBlock: { error in
            ViewHud.hideLoadView()
        }
        
    }
    
}
