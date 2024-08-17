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
    
    var h5type: String?
    
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
        moneyView.block1 = {btn, model in //enmu
            if let significant = model.significant {
                let modelArray = enmuModel.enumOneArr(dataSourceArr: significant)
                PopLastNumCifig.popLastEnum(.province, btn, modelArray, model)
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
        PLAAFNetWorkManager.shared.requestAPI(params: ["wears": h5type ?? "0", "appPay": "1", "googlePay": "2", "stud": "3"], pageUrl: "/ace/laugh/thisi/watani", method: .get) { [weak self] baseModel in
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
                if self?.h5type == "1" {
                    if let model = JSONDeserializer<wallpaperModel>.deserializeFrom(dict: baseModel.wallpaper) {
                        self?.changeBankInfo(model)
                    }
                }else {
                    if let self = self {
                        JudgeConfig.productDetailInfo(productID ?? "", "moneyall", form: self)
                    }
                    JudgeConfig.maidianxinxi(self?.productID ?? "", "8", self?.start ?? "")
                }
            }else {
                MBProgressHUD.wj_showPlainText(baseModel.formica ?? "", view: nil)
            }
        } errorBlock: { error in
            ViewHud.hideLoadView()
        }
    }
    
    func changeBankInfo(_ model: wallpaperModel) {
        ViewHud.addLoadView()
        PLAAFNetWorkManager.shared.requestAPI(params: ["fade": model.fade ?? "", "wider": "", "changeBank": "1"], pageUrl: "/ace/dipping/kidneys/things", method: .post) { [weak self] baseModel in
            ViewHud.hideLoadView()
            if baseModel.greasy == 0 || baseModel.greasy == 00 {
                if let model = JSONDeserializer<wallpaperModel>.deserializeFrom(dict: baseModel.wallpaper), let self = self {
                    let beige = model.beige ?? ""
                    if beige.isEmpty {
                        self.navigationController?.popViewController(animated: true)
                    }else {
                        JudgeConfig.judue(model.beige ?? "", from: self)
                    }
                }
            }
            MBProgressHUD.wj_showPlainText(baseModel.formica ?? "", view: nil)
        } errorBlock: { error in
            ViewHud.hideLoadView()
        }
    }
    
}
