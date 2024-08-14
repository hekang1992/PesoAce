//
//  PLAFaceViewController.swift
//  PesoAce
//
//  Created by apple on 2024/8/6.
//

import UIKit
import MBProgressHUD_WJExtension
import TYAlertController
import HandyJSON
import BRPickerView
import Kingfisher

class PLAFaceViewController: PLABaseViewController {
    
    lazy var faceView: PLAFaceView = {
        let faceView = PLAFaceView()
        return faceView
    }()
    
    lazy var popView: PLAPopPhotoView = {
        let popView = PLAPopPhotoView(frame: CGRect(x: 0, y: 124.px(), width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 124.px()))
        return popView
    }()
    
    lazy var popInfoView: PLAPMInfoView = {
        let popInfoView = PLAPMInfoView(frame: self.view.bounds)
        return popInfoView
    }()
    
    var model: cleanerModel?
    
    var productID: String?
    
    var shifoushangchuanid: String?
    
    var isFace: String = "0"
    
    var orbital: String?
    
    var start: String?
    
    lazy var idVc: PLAAuThAbcController = {
        let idVc = PLAAuThAbcController()
        return idVc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.addSubview(faceView)
        faceView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        faceView.block = { [weak self ] in
            self?.navigationController?.popViewController(animated: true)
        }
        faceView.block1 = { [weak self ] btn in
            self?.navigationController?.popViewController(animated: true)
        }
        faceView.block2 = { [weak self] btn in
            if let self = self {
                if self.shifoushangchuanid == "1" {
                    self.popRenlian()
                }else {
                    MBProgressHUD.wj_showPlainText("请先上传ID证件", view: nil)
                }
            }
        }
        faceView.block3 = { [weak self ] btn in
            self?.popP()
        }
        
        faceView.block4 = { [weak self ] btn in
            if let self = self {
                JudgeConfig.productDetailInfo(productID ?? "", form: self)
            }
        }
        
        self.faceView.idBtn1.kf.setImage(with: URL(string: model?.pic_url ?? ""), for: .normal)
        getFaceInfo {
            
        }
        start = DeviceInfo.getCurrentTime()
    }
    
}


extension PLAFaceViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func getFaceInfo(completion: @escaping () -> Void) {
        ViewHud.addLoadView()
        PLAAFNetWorkManager.shared.requestAPI(params: ["reputedly": productID ?? "", "face": "1"], pageUrl: "/ace/someones/because/glanced", method: .get) { [weak self] baseModel in
            ViewHud.hideLoadView()
            let success = baseModel.greasy
            if success == 0 || success == 00 {
                let model = JSONDeserializer<wallpaperModel>.deserializeFrom(dict: baseModel.wallpaper)
                self?.shifoushangchuanid = model?.al?.rail ?? ""
                self?.orbital = model?.orbital ?? ""
                if model?.al?.rail == "1" {
                    self?.faceView.idBtn1.kf.setImage(with: URL(string: model?.al?.minarets ?? ""), for: .normal)
                    self?.faceView.faceBtn1.kf.setImage(with: URL(string: model?.minarets ?? ""), for: .normal)
                }
                if self?.shifoushangchuanid == "1" && self?.orbital == "1" {
                    self?.faceView.loginBtn.isEnabled = true
                    self?.faceView.loginBtn.backgroundColor = UIColor.init(css: "#2681FB")
                }
            }
            completion()
        } errorBlock: { error in
            completion()
            ViewHud.hideLoadView()
        }
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        let data = Data.compressImageQuality(image: image!, maxLength: 1200)
        picker.dismiss(animated: true) { [weak self] in
            self?.shangchuantup(data!,image!)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func shangchuantup(_ data: Data, _ image: UIImage) {
        ViewHud.addLoadView()
        var dict: [String: String]?
        if self.isFace == "1" {
            dict = ["shakes": model?.asthma ?? "", "dle": "2", "reputedly": productID ?? "", "sighing": "1", "vacuumed": "10"]
        }else {
            dict = ["shakes": model?.asthma ?? "", "dle": "1", "reputedly": productID ?? "", "sighing": "1", "vacuumed": "11"]
        }
        PLAAFNetWorkManager.shared.uploadImageAPI(params: dict, pageUrl: "/ace/laughed/hurled/small", method: .post, data: data) { [weak self] baseModel in
            ViewHud.hideLoadView()
            let formica = baseModel.formica ?? ""
            if let greasy = baseModel.greasy, greasy == 0 || greasy == 00 {
                guard let model = JSONDeserializer<wallpaperModel>.deserializeFrom(dict: baseModel.wallpaper) else { return }
                DispatchQueue.main.async {
                    if self?.isFace == "0" {
                        self?.popMessage(from: model)
                    }else {
                        #warning("todo funk")
                        let dispatchGroup = DispatchGroup()
                        dispatchGroup.enter()
                        self?.getFaceInfo {
                            dispatchGroup.leave()
                        }
                        dispatchGroup.notify(queue: .main) {
                            JudgeConfig.maidianxinxi(self?.productID ?? "", "4", self?.start ?? "")
                        }
                    }
                }
            }
            MBProgressHUD.wj_showPlainText(formica, view: nil)
        } errorBlock: { error in
            ViewHud.hideLoadView()
        }
        
    }
    
    func popP() {
        let alertVc = TYAlertController(alert: popView, preferredStyle: .actionSheet)
        self.present(alertVc!, animated: true)
        popView.block = { [weak self] in
            self?.dismiss(animated: true)
        }
        popView.block1 = { [weak self] in
            self?.dismiss(animated: true, completion: {
                if let self = self {
                    self.isFace = "0"
                    PLAPhotoManager.shared.presentPhoto(from: self)
                }
            })
        }
        popView.block2 = { [weak self] in
            self?.dismiss(animated: true, completion: {
                if let self = self {
                    self.isFace = "0"
                    PLAPhotoManager.shared.presentCamera(from: self, isfront: "0")
                }
            })
        }
    }
    
    func popMessage(from model: wallpaperModel) {
        let alertVc = TYAlertController(alert: popInfoView, preferredStyle: .actionSheet, transitionAnimation: .fade)
        popInfoView.nameView.tectFie.text = model.asthma ?? ""
        popInfoView.idView.tectFie.text = model.liq ?? ""
        popInfoView.dateView.tectBtn.setTitle(model.fracture ?? "", for: .normal)
        self.present(alertVc!, animated: true)
        popInfoView.block = { [weak self] in
            self?.dismiss(animated: true)
        }
        popInfoView.block1 = { [weak self] btn in
            self?.settitme(btn)
        }
        popInfoView.saveblock = { [weak self] in
            self?.saveInfo()
        }
    }
    
    func settitme(_ btn: UIButton) {
        guard let timeStr = btn.titleLabel?.text else { return }
        let timeArray = timeStr.components(separatedBy: "-")
        let one = timeArray[0]
        let two = timeArray[1]
        let three = timeArray[2]
        
        let datePickerView = BRDatePickerView()
        datePickerView.pickerMode = .YMD
        datePickerView.title = "Date of birth"
        datePickerView.minDate = NSDate.br_setYear(1840, month: 1, day: 1)
        datePickerView.selectDate = NSDate.br_setYear(Int(three)!, month: Int(two)!, day: Int(one)!)
        datePickerView.maxDate = Date()
        datePickerView.resultBlock = { [weak self] selectDate, selectValue in
            let timeArray = selectValue!.components(separatedBy: "-")
            let year = timeArray[0]
            let mon = timeArray[1]
            let day = timeArray[2]
            self?.popInfoView.dateView.tectBtn.setTitle(String(format: "%@-%@-%@", day,mon,year), for: .normal)
        }
        let customStyle = BRPickerStyle()
        customStyle.pickerColor = .white
        customStyle.pickerTextFont = UIFont(name: black_font, size: 18.px())
        customStyle.selectRowTextColor = UIColor.init(css: "#2681FB")
        datePickerView.pickerStyle = customStyle
        datePickerView.show()
    }
    
    func saveInfo() {
        ViewHud.addLoadView()
        let dict = ["liq": self.popInfoView.idView.tectFie.text ?? "",
                    "fracture": self.popInfoView.dateView.tectBtn.titleLabel?.text ?? "",
                    "asthma": self.popInfoView.nameView.tectFie.text ?? "",
                    "vacuumed": "11",
                    "shakes": model?.asthma ?? "",
                    "cavity": "09"]
        PLAAFNetWorkManager.shared.requestAPI(params: dict, pageUrl: "/ace/toyed/mother/karteh", method: .post) { [weak self] baseModel in
            ViewHud.hideLoadView()
            let formica = baseModel.formica ?? ""
            if baseModel.greasy == 0 || baseModel.greasy == 00 {
                self?.dismiss(animated: true, completion: {
                    self?.getFaceInfo {
                        
                    }
                })
            }
            MBProgressHUD.wj_showPlainText(formica, view: nil)
            JudgeConfig.maidianxinxi(self?.productID ?? "", "3", self?.start ?? "")
        } errorBlock: { error in
            ViewHud.hideLoadView()
        }
        
    }
    
    func popRenlian() {
        let alertVc = TYAlertController(alert: popView, preferredStyle: .actionSheet)
        popView.bgImageView.image = UIImage(named: "Group_renlian")
        self.present(alertVc!, animated: true)
        popView.block = { [weak self] in
            self?.dismiss(animated: true)
        }
        popView.block2 = { [weak self] in
            self?.dismiss(animated: true, completion: {
                if let self = self {
                    self.isFace = "1"
                    PLAPhotoManager.shared.presentCamera(from: self, isfront: "1")
                }
            })
        }
    }
    
}
