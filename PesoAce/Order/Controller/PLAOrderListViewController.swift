//
//  PLAOrderListViewController.swift
//  PesoAce
//
//  Created by apple on 2024/8/6.
//

import UIKit
import HandyJSON

class PLAOrderListViewController: UIViewController {
    
    lazy var listView: PLAOrderListView = {
        let listView = PLAOrderListView()
        return listView
    }()
    
    var battered: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(listView)
        listView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        orderListPage(battered ?? "")
        print("battered>>>>>>>\(battered ?? "")")
    }
}


extension PLAOrderListViewController {
    
    
    #warning("todo fu")
    func orderListPage(_ battered: String) {
        ViewHud.addLoadView()
        let dict = ["battered": battered, "page": "1"]
        PLAAFNetWorkManager.shared.requestAPI(params: dict, pageUrl: "/ace/people/together/eyesa", method: .post) { [weak self] baseModel in
            ViewHud.hideLoadView()
            if let greasy = baseModel.greasy, greasy == 0 || greasy == 00 {
                if let model = JSONDeserializer<wallpaperModel>.deserializeFrom(dict: baseModel.wallpaper), let modelArray = model.cleaner, !modelArray.isEmpty {
                    EmptyConfig.hideEmptyView()
                }else {
                    self?.addemptyView()
                }
            }
        } errorBlock: { error in
            ViewHud.hideLoadView()
        }
    }
    
    func addemptyView () {
        listView.addSubview(EmptyConfig.emptyView)
        EmptyConfig.emptyView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}
