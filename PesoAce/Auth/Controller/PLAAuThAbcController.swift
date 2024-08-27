//
//  PLAAuThAbcController.swift
//  PesoAce
//
//  Created by apple on 2024/8/7.
//

import UIKit
import HandyJSON

class PLAAuThAbcController: UIViewController {
    
    lazy var pVeiw: PLAAuthIdView = {
        let pVeiw = PLAAuthIdView()
        pVeiw.backgroundColor = .white
        pVeiw.titltLabel.text = "Select the document type"
        return pVeiw
    }()
    
    var productID: String?
    
    var setp: String?
    
    var staartTIME: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(pVeiw)
        pVeiw.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        pVeiw.block = { [weak self ] in
            self?.navigationController?.popViewController(animated: true)
        }
        staartTIME = DeviceInfo.getCurrentTime()
        pVeiw.clickblock = { [weak self] model in
            let faceVc = PLAFaceViewController()
            faceVc.model = model
            faceVc.productID = self?.productID ?? ""
            JudgeConfig.maidianxinxi(self?.productID ?? "", "2", self?.staartTIME ?? "", DeviceInfo.getCurrentTime()) {
                
            }
            self?.navigationController?.pushViewController(faceVc, animated: true)
        }
        tupianInfo()
    }

}


extension PLAAuThAbcController {
    
    func tupianInfo() {
        ViewHud.addLoadView()
        PLAAFNetWorkManager.shared.requestAPI(params: [:], pageUrl: "/ace/saybut/obstinate/list", method: .post) { [weak self] baseModel in
            ViewHud.hideLoadView()
            if let greasy = baseModel.greasy, greasy == 0 || greasy == 00 {
                guard let model = JSONDeserializer<wallpaperModel>.deserializeFrom(dict: baseModel.wallpaper) else { return }
                self?.pVeiw.modelArray = model.cleaner
                self?.pVeiw.collectionView.reloadData()
            }
        } errorBlock: { error in
            ViewHud.hideLoadView()
        }
    }
    
}
