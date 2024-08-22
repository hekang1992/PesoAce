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
    
    var orderID: String?
    
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
            if let navigationController = self?.navigationController {
                JudgePushVcConfing.popToZhidingVc(ofClass: PLAOrderViewController.self, in: navigationController)
            }
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
            if baseModel.greasy == 0 || baseModel.greasy == 00 {
                if self?.h5type == "1" {
                    if let model = JSONDeserializer<wallpaperModel>.deserializeFrom(dict: baseModel.wallpaper) {
                        self?.changeBankInfo(model)
                    }
                }else {
                    if let self = self {
                        let dispatchGroup = DispatchGroup()
                        dispatchGroup.enter()
                        JudgeConfig.maidianxinxi(self.productID ?? "", "8", self.start ?? "") {
                            dispatchGroup.leave()
                        }
                        dispatchGroup.notify(queue: .main) {
                            JudgeConfig.productDetailInfo(self.productID ?? "", "moneyall", form: self)
                        }
                    }
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
        PLAAFNetWorkManager.shared.requestAPI(params: ["fade": model.fade ?? "", "wider": self.orderID ?? "", "changeBank": "1"], pageUrl: "/ace/dipping/kidneys/things", method: .post) { [weak self] baseModel in
            ViewHud.hideLoadView()
            if baseModel.greasy == 0 || baseModel.greasy == 00 {
                if let model = JSONDeserializer<wallpaperModel>.deserializeFrom(dict: baseModel.wallpaper), let self = self {
                    let beige = model.beige ?? ""
                    if beige.isEmpty {
                        self.navigationController?.popViewController(animated: true)
                    }else {
                        JudgeConfig.judue(model.beige ?? "", "moneyall", from: self)
                    }
                }
            }
            MBProgressHUD.wj_showPlainText(baseModel.formica ?? "", view: nil)
        } errorBlock: { error in
            ViewHud.hideLoadView()
        }
    }
}


class JudgePushVcConfing: NSObject {
    static func popToZhidingVc<T: PLABaseViewController>(ofClass: T.Type, in navigationController: UINavigationController) {
        for viewController in navigationController.viewControllers {
            if viewController.isKind(of: ofClass) {
                navigationController.popToViewController(viewController, animated: true)
                return
            }
        }
        // 如果没有找到匹配的视图控制器，弹出到根视图控制器
        navigationController.popToRootViewController(animated: true)
    }
}
