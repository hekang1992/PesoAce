//
//  PLAPersonAlViewController.swift
//  PesoAce
//
//  Created by apple on 2024/8/10.
//

import UIKit
import HandyJSON

class PLAPersonAlViewController: PLABaseViewController {
    
    var productID: String?
    
    lazy var perView: PLAPersonInfoXView = {
        let perView = PLAPersonInfoXView()
        return perView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(perView)
        perView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        perView.block = { [weak self] in
            self?.navigationController?.popToRootViewController(animated: true)
        }
        personalApi()
    }

}

extension PLAPersonAlViewController {
    
    func personalApi() {
        ViewHud.addLoadView()
        PLAAFNetWorkManager.shared.requestAPI(params: ["reputedly": productID ?? "", "shifou": "2", "upload": "1"], pageUrl: "/ace/cruiser/worrying/turned", method: .post) { [weak self] baseModel in
            ViewHud.hideLoadView()
            if let greasy = baseModel.greasy, greasy == 0 || greasy == 00 {
                guard let model = JSONDeserializer<wallpaperModel>.deserializeFrom(dict: baseModel.wallpaper) else { return }
                self?.perView.modelArray = model.lum
                self?.perView.tableView.reloadData()
            }
        } errorBlock: { error in
            ViewHud.hideLoadView()
        }

    }
    
    
}
