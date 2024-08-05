//
//  PLAHomeViewController.swift
//  PesoAce
//
//  Created by apple on 2024/8/4.
//

import UIKit
import MJRefresh
import MBProgressHUD_WJExtension
import HandyJSON

class PLAHomeViewController: PLABaseViewController {
    
    lazy var oneView = PLAHomeOneView()
    
    var model: improvementModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.addSubview(oneView)
        oneView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        oneView.applyBlock = { [weak self] in
            self?.shenqing(self?.model?.bellyaches ?? "")
        }
        let header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(handleRefresh))
            oneView.scrollView.mj_header = header
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        homedata()
    }
    
}

extension PLAHomeViewController {
    
    @objc func handleRefresh() {
        homedata()
    }
    
    func homedata() {
        ViewHud.addLoadView()
        PLAAFNetWorkManager.shared.requestAPI(params: ["home": "1"], pageUrl: "/ace/times/teacher/lined", method: .get) { [weak self] baseModel in
            ViewHud.hideLoadView()
            if let greasy = baseModel.greasy, greasy == 0 || greasy == 00 {
                guard let model = JSONDeserializer<wallpaperModel>.deserializeFrom(dict: baseModel.wallpaper) else { return }
                self?.model = model.tha?.improvement?.last
            }
            self?.oneView.scrollView.mj_header?.endRefreshing()
        } errorBlock: { error in
            ViewHud.hideLoadView()
        }
    }
    
    func shenqing(_ proID: String) {
        ViewHud.addLoadView()
        PLAAFNetWorkManager.shared.requestAPI(params: ["reputedly": proID, "moped": "1", "injection": "2"], pageUrl: "/ace/mattered/gravel/reading", method: .post) { [weak self] baseModel in
            ViewHud.hideLoadView()
            if let greasy = baseModel.greasy, greasy == 0 || greasy == 00 {
                guard let model = JSONDeserializer<wallpaperModel>.deserializeFrom(dict: baseModel.wallpaper), let self = self else { return }
                JudgeConfig.judue(model.minarets ?? "", from: self)
            }
        } errorBlock: { error in
            ViewHud.hideLoadView()
        }
    }
    
}
