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
import MBProgressHUD_WJExtension

class PLALXRViewController: PLABaseViewController {
    
    var productID: String?
    
    lazy var lianxirenView = PLALxiView()
    
    lazy var pickerVc: CNContactPickerViewController = {
        let pickerVc = CNContactPickerViewController()
        pickerVc.delegate = self
        pickerVc.displayedPropertyKeys = [CNContactPhoneNumbersKey]
        return pickerVc
    }()

    var btn: UIButton?
    
    var model: cleanerModel?
    
    var modelArray: [cleanerModel]?
    
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
        lianxirenView.block2 = { [weak self] btn, model in
            self?.btn = btn
            self?.model = model
            self?.alertlianxi(btn, model)
        }
        lianxirenView.saveblock = { [weak self] in
            let array = self?.modelArray?.map({ model in
                var result: [String: Any] = [:]
                result["escapes"] = model.escapes ?? ""
                result["asthma"] = model.asthma ?? ""
                result["bubbling"] = model.bubbling ?? ""
                result["plastics"] = model.plastics ?? ""
                return result
            })
            if let modelrray = array {
                self?.saveLianxiren(modelrray)
            }
        }
    }
}


extension PLALXRViewController: CNContactPickerDelegate {
    
    func getLianxi() {
        ViewHud.addLoadView()
        PLAAFNetWorkManager.shared.requestAPI(params: ["contract": "6", "reputedly": productID ?? "", "attaching": "1"], pageUrl: "/ace/shoving/halloween/phone", method: .post) { [weak self] baseModel in
            ViewHud.hideLoadView()
            if baseModel.greasy == 0 || baseModel.greasy == 00 {
                let model = JSONDeserializer<wallpaperModel>.deserializeFrom(dict: baseModel.wallpaper)
                let modelArray = model?.burns?.cleaner
                self?.modelArray = modelArray
                self?.lianxirenView.modelArray = modelArray
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
    
    func alertlianxi(_ btn: UIButton, _ emodel: cleanerModel) {
        present(pickerVc, animated: true, completion: nil)
    }
    
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        let nameStr = contact.givenName + " " + contact.familyName
        if let phoneNumber = contact.phoneNumbers.first?.value {
            let numberStr = phoneNumber.stringValue
            if let btn = self.btn {
                btn.setTitleColor(UIColor.init(css: "#2681FB"), for: .normal)
                btn.setTitle(nameStr + "-" + numberStr, for: .normal)
                model?.asthma = nameStr
                model?.escapes = numberStr
            }
        }
    }
    
    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        print("Contact selection canceled")
    }
    
    func saveLianxiren(_ array: [[String: Any]] ) {
        ViewHud.addLoadView()
        if let jsonshuju = try? JSONSerialization.data(withJSONObject: array, options: []) {
            if let jsonzifu = String(data: jsonshuju, encoding: .utf8){
                let dict = ["reputedly": productID ?? "", "lianxiwo": "haode", "wallpaper": jsonzifu, "buyaolianxi": "no"]
                PLAAFNetWorkManager.shared.uploadDataAPI(params: dict, pageUrl: "/ace/thinking/besting/afghanistanfarid", method: .post) { [weak self] baseModel in
                    ViewHud.hideLoadView()
                    if baseModel.greasy == 0 || baseModel.greasy == 00 {
                        if let self = self {
                            JudgeConfig.productDetailInfo(productID ?? "", form: self)
                        }
                    }else {
                        MBProgressHUD.wj_showPlainText(baseModel.formica ?? "", view: nil)
                    }
                } errorBlock: { error in
                    ViewHud.hideLoadView()
                }
            }
        }
    }
    
}
