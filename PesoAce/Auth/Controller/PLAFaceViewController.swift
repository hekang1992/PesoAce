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

class PLAFaceViewController: PLABaseViewController {
    
    lazy var faceView: PLAFaceView = {
        let faceView = PLAFaceView()
        return faceView
    }()
    
    lazy var popView: PLAPopPhotoView = {
        let popView = PLAPopPhotoView(frame: CGRect(x: 0, y: 124.px(), width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 124.px()))
        return popView
    }()
    
    var model: cleanerModel?
    
    var productID: String?
    
    var shifoushangchuanid: String?
    
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
                    PLAPhotoManager.shared.presentCamera(from: self, isfront: "1")
                }else {
                    MBProgressHUD.wj_showPlainText("请先上传ID证件", view: nil)
                }
            }
        }
        faceView.block3 = { [weak self ] btn in
            self?.popP()
        }
        self.faceView.idBtn1.kf.setImage(with: URL(string: model?.pic_url ?? ""), for: .normal)
        getFaceInfo()
    }

}


extension PLAFaceViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func getFaceInfo() {
        ViewHud.addLoadView()
        PLAAFNetWorkManager.shared.requestAPI(params: ["reputedly": productID ?? "", "face": "1"], pageUrl: "/ace/someones/because/glanced", method: .get) { [weak self] baseModel in
            ViewHud.hideLoadView()
            let success = baseModel.greasy
            if success == 0 || success == 00 {
                let model = JSONDeserializer<wallpaperModel>.deserializeFrom(dict: baseModel.wallpaper)
                self?.shifoushangchuanid = model?.al?.rail
            }
        } errorBlock: { error in
            ViewHud.hideLoadView()
        }

    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        let data = Data.compressImageQuality(image: image!, maxLength: 1800)
        picker.dismiss(animated: true) { [weak self] in
            self?.shangchuantup(data!,image!)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func shangchuantup(_ data: Data, _ image: UIImage) {
        ViewHud.addLoadView()
        let dict = ["shakes": model?.asthma ?? "", "dle": "1", "reputedly": productID ?? "", "sighing": "1", "vacuumed": "11"]
        PLAAFNetWorkManager.shared.uploadImageAPI(params: dict, pageUrl: "/ace/laughed/hurled/small", method: .post, data: data) { baseModel in
            ViewHud.hideLoadView()
            let formica = baseModel.formica ?? ""
            if let greasy = baseModel.greasy, greasy == 0 || greasy == 00 {
                guard let model = JSONDeserializer<wallpaperModel>.deserializeFrom(dict: baseModel.wallpaper) else { return }
                
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
                    PLAPhotoManager.shared.presentPhoto(from: self)
                }
            })
        }
        popView.block2 = { [weak self] in
            self?.dismiss(animated: true, completion: {
                if let self = self {
                    PLAPhotoManager.shared.presentCamera(from: self, isfront: "0")
                }
            })
        }
    }
    
}
