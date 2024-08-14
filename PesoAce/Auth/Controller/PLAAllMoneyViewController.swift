//
//  PLAAllMoneyViewController.swift
//  PesoAce
//
//  Created by apple on 2024/8/11.
//

import UIKit
import HandyJSON
import BRPickerView
import MBProgressHUD_WJExtension
import RxSwift

class PLAAllMoneyViewController: PLABaseViewController {
    
    var productID: String?
    
    var start: String?
    
    var setp: String?
    
    lazy var moneyView: PLAAllMoneyView = {
        let moneyView = PLAAllMoneyView()
        moneyView.stLabel.text = setp ?? ""
        return moneyView
    }()
    
    let subject = PublishSubject<Int>()
    
    var modelArray: [lumModel]?

    let disp = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(moneyView)
        huoquyinhanxinxi()
        moneyView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        moneyView.block = { [weak self] in
            self?.navigationController?.popToRootViewController(animated: true)
        }
        moneyView.block1 = { [weak self] btn, model in //enmu
            if let significant = model.significant {
                let modelArray = enmuModel.enumOneArr(dataSourceArr: significant)
                self?.popLastEnum(.province, btn, modelArray, model)
            }
        }
        moneyView.saveblock = { [weak self] index in
            self?.subject.onNext(index)
        }
        subject
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] index in
            self?.savebankInfo(index)
        }).disposed(by: disp)
        start = DeviceInfo.getCurrentTime()
    }
}

extension PLAAllMoneyViewController {
    
    func huoquyinhanxinxi() {
        ViewHud.addLoadView()
        PLAAFNetWorkManager.shared.requestAPI(params: ["wears": "0", "appPay": "1", "googlePay": "2", "stud": "3"], pageUrl: "/ace/laugh/thisi/watani", method: .get) { [weak self] baseModel in
            ViewHud.hideLoadView()
            if baseModel.greasy == 0 || baseModel.greasy == 00 {
                if let model = JSONDeserializer<wallpaperModel>.deserializeFrom(dict: baseModel.wallpaper) {
                    let modelArray = model.lum
                    self?.modelArray = modelArray
                    self?.moneyView.modelArray = modelArray
                }
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
            btn.setTitleColor(UIColor.init(css: "#2681FB"), for: .normal)
        }
        let customStyle = BRPickerStyle()
        customStyle.pickerColor = .white
        customStyle.pickerTextFont = UIFont(name: black_font, size: 18.px())
        customStyle.selectRowTextColor = UIColor.init(css: "#2681FB")
        addressPickerView.pickerStyle = customStyle
        addressPickerView.show()
    }
    
    func savebankInfo(_ index: Int) {
        var dict: [String: Any]?
        if let modelArray = modelArray?[index].lum {
            dict = modelArray.reduce(into: [String: Any](), { preesult, model in
                let type = model.pendu
                if type == "themselves1" || type == "themselves4" {
                    preesult[model.greasy!] = model.vacuumed
                }else {
                    preesult[model.greasy!] = model.shalwar
                }
            })
            dict?["shakes"] = index + 1
        }
        ViewHud.addLoadView()
        PLAAFNetWorkManager.shared.requestAPI(params: dict, pageUrl: "/ace/always/stringy/batted", method: .post) { [weak self] baseModel in
            ViewHud.hideLoadView()
            if baseModel.greasy == 0 || baseModel.greasy == 00 {
                if let self = self {
                    JudgeConfig.productDetailInfo(productID ?? "", "moneyall", form: self)
                }
                JudgeConfig.maidianxinxi(self?.productID ?? "", "8", self?.start ?? "")
            }else {
                MBProgressHUD.wj_showPlainText(baseModel.formica ?? "", view: nil)
            }
        } errorBlock: { error in
            ViewHud.hideLoadView()
        }

    }
    
}
