//
//  PLAChangeBankViewController.swift
//  PesoAce
//
//  Created by 何康 on 2024/8/16.
//

import UIKit
import HandyJSON

class PLAChangeBankViewController: PLABaseViewController {
    
    lazy var cbankView: PLAChangeBankView = {
        let cbankView = PLAChangeBankView()
        return cbankView
    }()
    
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
            self?.navigationController?.pushViewController(moneyVc, animated: true)
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
                if let model = JSONDeserializer<wallpaperModel>.deserializeFrom(dict: baseModel.wallpaper), let modelaRR = model.cleaner {
                    let sections = modelaRR.map { model -> CleanerSectionModel in
                        let millah = model.millah ?? ""
                        let items = model.improvement ?? []
                        return CleanerSectionModel(millah: millah, items: items)
                    }
                    self?.cbankView.modelArray.accept(sections)
                    self?.cbankView.tableView.reloadData()
                }
            }
        } errorBlock: { error in
            ViewHud.hideLoadView()
        }
    }
    
}
