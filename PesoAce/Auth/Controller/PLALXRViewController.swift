//
//  PLALXRViewController.swift
//  PesoAce
//
//  Created by apple on 2024/8/11.
//

import UIKit
import HandyJSON
import BRPickerView
import ContactsUI

class PLALXRViewController: PLABaseViewController {
    
    var productID: String?
    
    lazy var lianxirenView = PLALxiView()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        getLianxi()
        view.addSubview(lianxirenView)
        lianxirenView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        lianxirenView.block = { [weak self] in
            self?.navigationController?.popToRootViewController(animated: true)
        }
        lianxirenView.block1 = { [weak self] btn, model in
            if let pakols = model.pakols {
                let modelArray = enmuModel.enumOneArr(dataSourceArr: pakols)
                self?.popLastEnum(.province, btn, modelArray, model)
            }
        }
        lianxirenView.block2 = { [weak self] btn in

        }
    }
}


extension PLALXRViewController {
    
    func getLianxi() {
        ViewHud.addLoadView()
        PLAAFNetWorkManager.shared.requestAPI(params: ["contract": "6", "reputedly": productID ?? "", "attaching": "1"], pageUrl: "/ace/shoving/halloween/phone", method: .post) { [weak self] baseModel in
            ViewHud.hideLoadView()
            if baseModel.greasy == 0 || baseModel.greasy == 00 {
                let model = JSONDeserializer<wallpaperModel>.deserializeFrom(dict: baseModel.wallpaper)
                self?.lianxirenView.modelArray = model?.burns?.cleaner
                self?.lianxirenView.tableView.reloadData()
            }
        } errorBlock: { error in
            ViewHud.hideLoadView()
        }

    }
    
    func popLastEnum(_ model: BRAddressPickerMode, _ btn : UIButton, _ array: [BRProvinceModel], _ modelDate: cleanerModel) {
        let addressPickerView = BRAddressPickerView()
        addressPickerView.title = modelDate.plastics ?? ""
        addressPickerView.pickerMode = model
        addressPickerView.selectIndexs = [0, 0, 0]
        addressPickerView.dataSourceArr = array
        addressPickerView.resultBlock = { province, city, area in
            
            let provinceCode = province?.code ?? ""
            let cityCode = city?.code ?? ""
            let areaCode = area?.code ?? ""
            
            let provinceName = province?.name ?? ""
            let cityName = city?.name ?? ""
            let areaName = area?.name ?? ""
            
            var addressString: String = ""
            var code: String = ""
            if cityName.isEmpty {
                addressString = provinceName
                code = provinceCode
            }else if areaName.isEmpty {
                addressString = provinceName + " - " + cityName
                code = provinceCode + " - " + cityCode
            }else {
                addressString = provinceName + " - " + cityName + " - " + areaName
                code = provinceCode + " - " + cityCode + " - " + areaCode
            }
            modelDate.bubbling = code
            btn.setTitle(addressString, for: .normal)
            btn.setTitleColor(UIColor.init(css: "#2681FB"), for: .normal)
        }
        let customStyle = BRPickerStyle()
        customStyle.pickerColor = .white
        customStyle.pickerTextFont = UIFont(name: black_font, size: 18.px())
        customStyle.selectRowTextColor = UIColor.init(css: "#2681FB")
        addressPickerView.pickerStyle = customStyle
        addressPickerView.show()
    }
    
}
