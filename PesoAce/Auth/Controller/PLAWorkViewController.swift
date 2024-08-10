//
//  PLAWorkViewController.swift
//  PesoAce
//
//  Created by apple on 2024/8/11.
//

import UIKit
import HandyJSON
import BRPickerView
import MBProgressHUD_WJExtension

class PLAWorkViewController: PLABaseViewController {
    
    var productID: String?
    
    var cleaner: [cleanerModel]?
    
    var modelArray: [lumModel]?
    
    lazy var perView: PLAPersonInfoXView = {
        let perView = PLAPersonInfoXView()
        perView.titleLabel.text = "Work Infomation"
        perView.stLabel1.text = "Work Infomation"
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
        perView.block1 = { [weak self] btn, model in //enmu
            if let significant = model.significant {
                let modelArray = enmuModel.enumOneArr(dataSourceArr: significant)
                self?.popLastEnum(.province, btn, modelArray, model)
            }
        }
        perView.block3 = { [weak self] btn, model in //city
            self?.cituAllInfo(btn, model)
        }
        perView.block4 = { [weak self] btn, model in //date
            
        }
        perView.saveblock = { [weak self] in
            self?.savePPPInfo()
        }
        personalApi()
    }
    
}

extension PLAWorkViewController {
    
    func personalApi() {
        ViewHud.addLoadView()
        PLAAFNetWorkManager.shared.requestAPI(params: ["reputedly": productID ?? "", "shifou": "2", "upload": "1"], pageUrl: "/ace/remember/brought/welfare", method: .post) { [weak self] baseModel in
            ViewHud.hideLoadView()
            if let greasy = baseModel.greasy, greasy == 0 || greasy == 00 {
                guard let model = JSONDeserializer<wallpaperModel>.deserializeFrom(dict: baseModel.wallpaper) else { return }
                self?.perView.modelArray = model.lum
                self?.modelArray = model.lum
                self?.perView.tableView.reloadData()
            }
        } errorBlock: { error in
            ViewHud.hideLoadView()
        }
    }
    
    func popLastEnum(_ model: BRAddressPickerMode, _ btn : UIButton, _ array: [BRProvinceModel], _ modelDate: lumModel) {
        let addressPickerView = BRAddressPickerView()
        addressPickerView.title = modelDate.landlord ?? ""
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
            modelDate.shalwar = addressString
            modelDate.vacuumed = code
            btn.setTitle(modelDate.shalwar ?? "", for: .normal)
            btn.setTitleColor(.black, for: .normal)
        }
        let customStyle = BRPickerStyle()
        customStyle.pickerColor = .white
        customStyle.pickerTextFont = UIFont(name: black_font, size: 18.px())
        customStyle.selectRowTextColor = UIColor.init(css: "#2681FB")
        addressPickerView.pickerStyle = customStyle
        addressPickerView.show()
    }
    
    func cituAllInfo(_ btn: UIButton, _ lmodel: lumModel) {
        if cleaner != nil {
            let modelArray = CityXuanZe.cityModelArray(dataSourceArr: cleaner!)
            self.popLastEnum(.area, btn, modelArray, lmodel)
        }else {
            ViewHud.addLoadView()
            PLAAFNetWorkManager.shared.requestAPI(params: ["city": "1"], pageUrl: "/ace/looked/right/overshadowed", method: .get) { [weak self] baseModel in
                ViewHud.hideLoadView()
                let greasy = baseModel.greasy
                if greasy == 0 || greasy == 00 {
                    let model = JSONDeserializer<wallpaperModel>.deserializeFrom(dict: baseModel.wallpaper)
                    if let model = model {
                        self?.cleaner = model.cleaner
                        if let cleaner = model.cleaner {
                            let modelArray = CityXuanZe.cityModelArray(dataSourceArr: cleaner)
                            self?.popLastEnum(.area, btn, modelArray, lmodel)
                        }
                    }
                }
            } errorBlock: { error in
                ViewHud.hideLoadView()
            }
        }
    }
    
    func savePPPInfo() {
        var dict: [String: Any]?
        if let modelArray = modelArray {
            dict = modelArray.reduce(into: [String: Any](), { preesult, model in
                let type = model.pendu
                if type == "themselves1" || type == "themselves4" {
                    preesult[model.greasy!] = model.vacuumed
                }else {
                    preesult[model.greasy!] = model.shalwar
                }
            })
        }
        dict?["reputedly"] = productID ?? ""
        dict?["hemorrhage"] = "1"
        dict?["brought"] = "2"
        ViewHud.addLoadView()
        PLAAFNetWorkManager.shared.requestAPI(params: dict, pageUrl: "/ace/railroads/truck/swivel", method: .post) { [weak self] baseModel in
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
