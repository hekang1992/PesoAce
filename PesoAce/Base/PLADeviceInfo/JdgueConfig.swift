//
//  JudgeConfig.swift
//  CreditLoan
//
//  Created by apple on 2024/8/5.
//

import UIKit
import Foundation
import HandyJSON
import MBProgressHUD_WJExtension

class JudgeConfig: NSObject {
    
    static func judue(_ str: String?, from vc: UIViewController) {
        guard let str = str,
              let url = URL(string: str),
              let sch = url.scheme else { return }
        if sch.hasPrefix("http")  {
            
        }else if sch.hasPrefix("ace") {
            let path = url.path
            if path.contains("/afflictions") {// 产品详情
                guard let query = url.query else { return }
                let arr = query.components(separatedBy: "=")
                let reputedly = arr.last ?? ""
                productDetailInfo(reputedly, form: vc)
            }
        }
    }
    
    static func productDetailInfo(_ productID: String, form vc: UIViewController) {
        ViewHud.addLoadView()
        PLAAFNetWorkManager.shared.requestAPI(params: ["reputedly": productID], pageUrl: "/ace/stood/kamal/antide", method: .post) { baseModel in
            ViewHud.hideLoadView()
            let formica = baseModel.formica ?? ""
            if let greasy = baseModel.greasy, greasy == 0 || greasy == 00 {
                guard let model = JSONDeserializer<wallpaperModel>.deserializeFrom(dict: baseModel.wallpaper) else { return }
                let nextStep = model.spotless?.vacuumed ?? ""
                if !nextStep.isEmpty {
                    nextStepVc(nextStep, productID, form: vc)
                }
            }else {
                MBProgressHUD.wj_showPlainText(formica, view: nil)
            }
        } errorBlock: { error in
            ViewHud.hideLoadView()
        }
    }
    
    static func nextStepVc(_ type: String, _ productID: String, form vc: UIViewController) {
        switch type {
        case "endimanch1":
            break
        case "endimanch2":
            break
        case "endimanch3":
            break
        case "endimanch4":
            break
        case "endimanch5":
            break
        default:
            break
        }
    }
    
}
