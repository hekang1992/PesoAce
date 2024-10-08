//
//  PLAOrderListViewController.swift
//  PesoAce
//
//  Created by apple on 2024/8/6.
//

import UIKit
import HandyJSON
import JXSegmentedView
import MJRefresh

class PLAOrderListViewController: PLABaseViewController {
    
    lazy var listView: PLAOrderListView = {
        let listView = PLAOrderListView()
        return listView
    }()
    
    lazy var emptyView: PLAEmptyView = {
        let emptyView = PLAEmptyView()
        return emptyView
    }()
    
    var battered: String?
    
    var block: ((String) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(listView)
        listView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        listView.block = { [weak self] url in
            self?.block?(url)
        }
        listView.block1 = { [weak self] url in
            self?.block?(url)
        }
        self.listView.tableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(handleRefresh))
    }
    
}

extension PLAOrderListViewController {
    
    @objc func handleRefresh() {
        orderListPage(battered ?? "")
    }

    func orderListPage(_ battered: String) {
        ViewHud.addLoadView()
        self.battered = battered
        let dict = ["battered": battered, "page": "1"]
        PLAAFNetWorkManager.shared.requestAPI(params: dict, pageUrl: "/ace/people/together/eyesa", method: .post) { [weak self] baseModel in
            ViewHud.hideLoadView()
            if let greasy = baseModel.greasy, greasy == 0 || greasy == 00 {
                if let model = JSONDeserializer<wallpaperModel>.deserializeFrom(dict: baseModel.wallpaper), let modelArray = model.cleaner, !modelArray.isEmpty {
                    self?.emptyView.removeFromSuperview()
                    self?.listView.modelArray = modelArray
                    self?.listView.tableView.reloadData()
                }else {
                    self?.addemptyView()
                }
            }else {
                self?.addemptyView()
            }
            self?.listView.tableView.mj_header?.endRefreshing()
        } errorBlock: { [weak self] error in
            self?.addemptyView()
            ViewHud.hideLoadView()
            self?.listView.tableView.mj_header?.endRefreshing()
        }
    }
    
    func addemptyView () {
        DispatchQueue.main.async {
            self.listView.addSubview(self.emptyView)
            self.emptyView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
        
    }
    
}
