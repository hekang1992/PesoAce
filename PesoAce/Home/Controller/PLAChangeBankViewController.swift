//
//  PLAChangeBankViewController.swift
//  PesoAce
//
//  Created by 何康 on 2024/8/16.
//

import UIKit
import HandyJSON
import MBProgressHUD_WJExtension

class PLAChangeBankViewController: PLABaseViewController {
    
    lazy var cbankView: PLAChangeBankView = {
        let cbankView = PLAChangeBankView()
        return cbankView
    }()
    
    lazy var emptyView: PLAEmptyView = {
        let emptyView = PLAEmptyView()
        return emptyView
    }()
    
    var productID: String?
    
    var orderID: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.addSubview(cbankView)
        cbankView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        cbankView.block = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        cbankView.block1 = { [weak self] in
            let moneyVc = PLAAllMoneyViewController()
            moneyVc.h5type = "1"
            moneyVc.orderID = self?.orderID
            self?.navigationController?.pushViewController(moneyVc, animated: true)
        }
        cbankView.block2 = { [weak self] model in
            self?.changeBankInfo(model)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bankInfo()
    }
    
}

extension PLAChangeBankViewController {
    func bankInfo() {
        ViewHud.addLoadView()
        PLAAFNetWorkManager.shared.requestAPI(params: ["isbank": "1", "change": "1", "wa": "6"], pageUrl: "/ace/looked/dello/there", method: .post) { [weak self] baseModel in
            ViewHud.hideLoadView()
            if baseModel.greasy == 0 || baseModel.greasy == 00 {
                if let model = JSONDeserializer<wallpaperModel>.deserializeFrom(dict: baseModel.wallpaper), let modelaRR = model.cleaner, modelaRR.count > 0 {
                    let sections = modelaRR.map { model -> CleanerSectionModel in
                        let millah = model.millah ?? ""
                        let items = model.improvement ?? []
                        return CleanerSectionModel(millah: millah, items: items)
                    }
                    self?.cbankView.modelArray.accept(sections)
                    self?.cbankView.tableView.reloadData()
                }else {
                    self?.addemptyView()
                }
            }else {
                self?.addemptyView()
            }
        } errorBlock: { [weak self] error in
            self?.addemptyView()
            ViewHud.hideLoadView()
        }
    }
    
    func addemptyView () {
        DispatchQueue.main.async {
            self.cbankView.addSubview(self.emptyView)
            self.emptyView.snp.makeConstraints { make in
                make.left.bottom.right.equalToSuperview()
                make.top.equalTo(self.cbankView.titltLabel.snp.bottom).offset(8.px())
            }
        }
        
    }
    
    func changeBankInfo(_ model: improvementModel) {
        ViewHud.addLoadView()
        PLAAFNetWorkManager.shared.requestAPI(params: ["bankNo": model.podge ?? "", "fade": model.fade ?? "", "wider": orderID ?? "", "changeBank": "1"], pageUrl: "/ace/dipping/kidneys/things", method: .post) { [weak self] baseModel in
            ViewHud.hideLoadView()
            if baseModel.greasy == 0 || baseModel.greasy == 00 {
                if let model = JSONDeserializer<wallpaperModel>.deserializeFrom(dict: baseModel.wallpaper), let self = self {
                    self.bankInfo()
                    JudgeConfig.judue(model.beige ?? "", "moneyall", from: self)
                }
            }
            MBProgressHUD.wj_showPlainText(baseModel.formica ?? "", view: nil)
        } errorBlock: { error in
            ViewHud.hideLoadView()
        }
    }
    
}
