//
//  PLAJiaLianxiViewController.swift
//  PesoAce
//
//  Created by 何康 on 2024/8/17.
//

import UIKit
import HandyJSON
import BRPickerView
import ContactsUI

class PLAJiaLianxiViewController: PLABaseViewController {
    
    var productID: String?
    
    var setp: String?
    
    var btn: UIButton?
    
    var model: cleanerModel?
    
    var modelArray: [cleanerModel]?
    
    var start: String?
    
    lazy var lianxiView: PLAJiaLianxiView = {
        let lianxiView = PLAJiaLianxiView()
        return lianxiView
    }()
    
    lazy var pickerVc: CNContactPickerViewController = {
        let pickerVc = CNContactPickerViewController()
        pickerVc.delegate = self
        pickerVc.displayedPropertyKeys = [CNContactPhoneNumbersKey]
        return pickerVc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        huoquxinxi()
        view.addSubview(lianxiView)
        lianxiView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        lianxiView.stLabel.text = setp ?? ""
        lianxiView.block = { [weak self] in
            self?.navigationController?.popToRootViewController(animated: true)
        }
        lianxiView.block1 = { [weak self] btn, model in
            self?.view.endEditing(true)
            if let pakols = model.pakols {
                let modelArray = enmuModel.enumOneArr(dataSourceArr: pakols)
                self?.popLastEnum(.province, btn, modelArray, model)
            }
        }
        lianxiView.block2 = { [weak self] btn, model in
            self?.view.endEditing(true)
            self?.btn = btn
            self?.model = model
            self?.alertlianxi(btn, model)
        }
        lianxiView.saveblock = { [weak self] in
            self?.saveInfo()
        }
        start = DeviceInfo.getCurrentTime()
    }
}

extension PLAJiaLianxiViewController: CNContactPickerDelegate {
    
    func huoquxinxi() {
        ViewHud.addLoadView()
        PLAAFNetWorkManager.shared.requestAPI(params: ["reputedly": productID ?? ""], pageUrl: "/ace/shoving/halloween/phone", method: .post) { [weak self] baseModel in
            ViewHud.hideLoadView()
            if baseModel.greasy == 0 || baseModel.greasy == 00 {
                if let model = JSONDeserializer<wallpaperModel>.deserializeFrom(dict: baseModel.wallpaper), let modelArray = model.burns?.cleaner {
                    self?.modelArray = modelArray
                    self?.lianxiView.modelArray.accept(modelArray)
                    self?.lianxiView.tableView.reloadData()
                }
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
    
    func saveInfo() {
        var dict: [String: Any]?
        if let modelArray = modelArray {
            dict = modelArray.reduce(into: [String: Any](), { preesult, model in
                let type = model.pendu
                if type == "themselves2" {
                    preesult[model.greasy!] = model.shalwar
                }else {
                    guard let modelArray = self.modelArray else { return }
                    let resultArray = modelArray.map { model -> [String: Any] in
                        var dict: [String: Any] = [:]
                        if let escapes = model.escapes {
                            dict["escapes"] = escapes
                        }
                        if let asthma = model.asthma {
                            dict["asthma"] = asthma
                        }
                        if let bubbling = model.bubbling {
                            dict["bubbling"] = bubbling
                        }
                        if let plastics = model.plastics {
                            dict["plastics"] = plastics
                        }
                        return dict
                    }
                    let filteredArray = resultArray.filter { !$0.isEmpty }
                    if let jsonshuju = try? JSONSerialization.data(withJSONObject: filteredArray, options: []) {
                        if let jsonzifu = String(data: jsonshuju, encoding: .utf8){
                            preesult["wallpaper"] = jsonzifu
                        }
                    }
                }
            })
            ViewHud.addLoadView()
            dict?["reputedly"] = productID ?? ""
            PLAAFNetWorkManager.shared.uploadDataAPI(params: dict, pageUrl: "/ace/garden/would/shelf", method: .post) { [weak self] baseModel in
                ViewHud.hideLoadView()
                if baseModel.greasy == 0 || baseModel.greasy == 00 {
                    if let self = self {
                        JudgeConfig.productDetailInfo(productID ?? "", "", form: self)
                        JudgeConfig.maidianxinxi(self.productID ?? "", "7", self.start ?? "")
                    }
                }
            } errorBlock: { error in
                ViewHud.hideLoadView()
            }
        }
    }
    
}
