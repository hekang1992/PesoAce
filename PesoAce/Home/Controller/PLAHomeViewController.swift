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
import GYSide

class PLAHomeViewController: PLABaseViewController {
    
    lazy var oneView = PLAHomeOneView()
    
    lazy var mainView = PLAMainHomeView()
    
    var header: MJRefreshNormalHeader?
    
    var model: improvementModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.addSubview(oneView)
        view.addSubview(mainView)
        oneView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        mainView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        self.oneView.isHidden = true
        self.mainView.isHidden = true
        oneView.applyBlock = { [weak self] in
            if IS_LOGIN {
                self?.shenqing(self?.model?.bellyaches ?? "")
            }else {
                let loginVc = PLALoginViewController()
                self?.navigationController?.pushViewController(loginVc, animated: true)
            }
        }
        oneView.leftBlock = { [weak self] in
            self?.leftVc()
        }
        oneView.picBlock = { [weak self] url in
            if let self = self {
                if !url.isEmpty {
                    JudgeConfig.judue(url, "", from: self)
                }
            }
        }
        mainView.proUrlBlock = { [weak self] proid in
            if let self = self {
                self.shenqing(proid)
            }
        }
        mainView.leftBolck = { [weak self] in
            self?.leftVc()
        }
        mainView.rightBolck = { [weak self] in
            let webVc = PLAWebViewController()
            if let requestUrl = JudgeConfig.createRequsetURL(baseURL: h5Url + "/takasaki", params: PLALoginFactory.getLoginParas()) {
                webVc.productUrl = requestUrl
            }
            self?.navigationController?.pushViewController(webVc, animated: true)
        }
        mainView.picBlock = { [weak self] url in
            if let self = self {
                if !url.isEmpty {
                    JudgeConfig.judue(url, "", from: self)
                }
            }
        }
        mainView.picBlock1 = { [weak self] url in
            if let self = self {
                if !url.isEmpty {
                    JudgeConfig.judue(url, "", from: self)
                }
            }
        }
        header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(handleRefresh))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        homedata()
    }
    
}

extension PLAHomeViewController {
    
    func leftVc() {
        if IS_LOGIN {
            let vc = PLALeftSideViewController()
            gy_showSide({ (config) in
                config.animationType = .translationMask
                config.sideRelative = 0.68
            }, vc)
        }else {
            let loginVc = PLALoginViewController()
            self.navigationController?.pushViewController(loginVc, animated: true)
        }
    }
    
    @objc func handleRefresh() {
        homedata()
    }
    
    func homedata() {
        ViewHud.addLoadView()
        PLAAFNetWorkManager.shared.requestAPI(params: ["home": "1"], pageUrl: "/ace/times/teacher/lined", method: .get) { [weak self] baseModel in
            ViewHud.hideLoadView()
            if let greasy = baseModel.greasy, greasy == 0 || greasy == 00 {
                guard let model = JSONDeserializer<wallpaperModel>.deserializeFrom(dict: baseModel.wallpaper) else { return }
                if model.fast_list != nil {
                    self?.mainView.isHidden = false
                    self?.oneView.isHidden = true
                    if let array = model.fast_list?.improvement, let bb = model.spotless?.improvement {
                        self?.mainView.modelArray.accept(array)
                        self?.mainView.bannerArray = bb
                        if let overdueArray = model.overdue?.improvement {
                            self?.mainView.overdueArray.accept(overdueArray)
                        }
                    }
                    self?.mainView.tableView.reloadData()
                    self?.mainView.tableView.mj_header = self?.header
                }else {
                    self?.oneView.isHidden = false
                    self?.mainView.isHidden = true
                    self?.model = model.tha?.improvement?.last
                    let modelArray = model.spotless?.improvement
                    self?.oneView.modelArray = modelArray
                    self?.oneView.scrollView.mj_header = self?.header
                }
            }
            self?.mainView.tableView.mj_header?.endRefreshing()
            self?.oneView.scrollView.mj_header?.endRefreshing()
        } errorBlock: { [weak self] error in
            ViewHud.hideLoadView()
            self?.mainView.tableView.mj_header?.endRefreshing()
            self?.oneView.scrollView.mj_header?.endRefreshing()
        }
    }
    
    func shenqing(_ proID: String) {
        ViewHud.addLoadView()
        PLAAFNetWorkManager.shared.requestAPI(params: ["reputedly": proID, "moped": "1", "injection": "2"], pageUrl: "/ace/mattered/gravel/reading", method: .post) { [weak self] baseModel in
            ViewHud.hideLoadView()
            if let greasy = baseModel.greasy, greasy == 0 || greasy == 00 {
                guard let model = JSONDeserializer<wallpaperModel>.deserializeFrom(dict: baseModel.wallpaper), let self = self else { return }
                JudgeConfig.judue(model.minarets ?? "", "", from: self)
            }
        } errorBlock: { error in
            ViewHud.hideLoadView()
        }
    }
}
