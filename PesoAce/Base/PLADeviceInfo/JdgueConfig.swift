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
    
    static var start: String = DeviceInfo.getCurrentTime()
    
    static func judue(_ str: String?, _ type: String, from vc: PLABaseViewController) {
        guard let str = str,
              let url = URL(string: str),
              let sch = url.scheme else { return }
        if sch.hasPrefix("http")  {
            pushWebVc(str, type, form: vc)
        }else if sch.hasPrefix("ace") {
            let path = url.path
            if path.contains("/afflictions") {// 产品详情
                guard let query = url.query else { return }
                let arr = query.components(separatedBy: "=")
                let reputedly = arr.last ?? ""
                productDetailInfo(reputedly, "", form: vc)
            } else if path.contains("/sensibility") {
                vc.navigationController?.popToRootViewController(animated: true)
            } else if path.contains("/assurance") {
                if let reputedlyRange = str.range(of: "reputedly=")?.upperBound,
                   let andSymbolRange = str.range(of: "&", range: reputedlyRange..<str.endIndex)?.lowerBound, let biryaniRange = str.range(of: "biryani=")?.upperBound {
                    let productID = str[reputedlyRange..<andSymbolRange]
                    let orderID = str[biryaniRange..<str.endIndex]
                    let banVc = PLAChangeBankViewController()
                    banVc.productID = String(productID)
                    banVc.orderID = String(orderID)
                    vc.navigationController?.pushViewController(banVc, animated: true)
                }
            } else if path.contains("/hideously") {
                let orVc = PLAOrderViewController()
                vc.navigationController?.pushViewController(orVc, animated: true)
            }
        }else {
            return
        }
    }
    
    static func productDetailInfo(_ productID: String, _ type: String , form vc: PLABaseViewController) {
        ViewHud.addLoadView()
        PLAAFNetWorkManager.shared.requestAPI(params: ["reputedly": productID], pageUrl: "/ace/stood/kamal/antide", method: .post) { baseModel in
            let formica = baseModel.formica ?? ""
            if let greasy = baseModel.greasy, greasy == 0 || greasy == 00 {
                guard let model = JSONDeserializer<wallpaperModel>.deserializeFrom(dict: baseModel.wallpaper) else { return }
                let nextStep = model.jokingly?.outgrown ?? ""
                let process = model.jokingly?.process ?? ""
                let safely = model.conscience?.safely ?? ""
                if !nextStep.isEmpty {
                    nextStepVc(nextStep, productID, process, form: vc)
                }else {
                    nextOrderid(safely, type, productID, form: vc)
                }
            }else {
                MBProgressHUD.wj_showPlainText(formica, view: nil)
            }
            ViewHud.hideLoadView()
        } errorBlock: { error in
            ViewHud.hideLoadView()
        }
    }
    
    static func nextStepVc(_ type: String, _ productID: String, _ process: String, form vc: PLABaseViewController) {
        switch type {
        case "afterwards1":
            let faceVc = PLAAuThAbcController()
            faceVc.productID = productID
            faceVc.setp = process
            vc.navigationController?.pushViewController(faceVc, animated: true)
            break
        case "afterwards2":
            let personalVc = PLAPersonAlViewController()
            personalVc.productID = productID
            personalVc.setp = process
            vc.navigationController?.pushViewController(personalVc, animated: true)
            break
        case "afterwards3":
            let workVc = PLAWorkViewController()
            workVc.productID = productID
            workVc.setp = process
            vc.navigationController?.pushViewController(workVc, animated: true)
            break
        case "afterwards4":
            let lianxiVc = PLALXRViewController()
            lianxiVc.productID = productID
            lianxiVc.setp = process
            vc.navigationController?.pushViewController(lianxiVc, animated: true)
            break
        case "afterwards5":
            let moneyVc = PLAAllMoneyViewController()
            moneyVc.productID = productID
            moneyVc.setp = process
            vc.navigationController?.pushViewController(moneyVc, animated: true)
            break
        case "afterwards6":
            let jiaVc = PLAJiaLianxiViewController()
            jiaVc.productID = productID
            jiaVc.setp = process
            vc.navigationController?.pushViewController(jiaVc, animated: true)
            break
        default:
            break
        }
    }
    
    static func nextOrderid(_ type: String, _ tt: String, _ productID: String, form vc: PLABaseViewController) {
        ViewHud.addLoadView()
        PLAAFNetWorkManager.shared.requestAPI(params: ["wounded": "2",
                                                       "wider": type,
                                                       "screams": productID,
                                                       "pavement": "1",
                                                       "bulging": "2",
                                                       "oo": "1"], pageUrl: "/ace/wellshe/saying/anymorebut", method: .post) { baseModel in
            ViewHud.hideLoadView()
            if baseModel.greasy == 0 || baseModel.greasy == 00 {
                if let model = JSONDeserializer<wallpaperModel>.deserializeFrom(dict: baseModel.wallpaper) {
                    let productUrl = model.minarets ?? ""
                    pushWebVc(productUrl, tt, form: vc)
                }
            }
            JudgeConfig.maidianxinxi(productID, "9", start, DeviceInfo.getCurrentTime()){
                
            }
        } errorBlock: { error in
            ViewHud.hideLoadView()
        }
        
    }
    
    static func pushWebVc(_ url: String, _ type: String, form vc: PLABaseViewController) {
        let webVc = PLAWebViewController()
        if let requestUrl = createRequsetURL(baseURL: url, params: PLALoginFactory.getLoginParas()) {
            webVc.type = type
            webVc.productUrl = requestUrl
        }
        vc.navigationController?.pushViewController(webVc, animated: true)
    }
    
    static func maidianxinxi(_ proid: String, _ type: String, _ start: String, _ endTime: String, completion: @escaping () -> Void){
        let localtion = PLALocation()
        localtion.startUpdatingLocation { locationModel in
            PLAAFNetWorkManager.shared.requestAPI(params: ["login_apple": "1", "peck": proid, "jabbing": type, "nail": DeviceInfo.getIDFV(), "warmed": DeviceInfo.getIDFA(), "grasping": locationModel.grasping, "ome": locationModel.ome, "clarity": start, "curls": endTime, "shining": "1"], pageUrl: "/ace/maplenow/margins/lovemaking", method: .post) { baseModel in
                completion()
            } errorBlock: { error in
                completion()
            }
        }
    }
    
    static func createRequsetURL(baseURL: String, params: [String: String]) -> String? {
        guard var urlComponents = URLComponents(string: baseURL) else {
            return nil
        }
        var queryItems = urlComponents.queryItems ?? []
        for (key, value) in params {
            let queryItem = URLQueryItem(name: key, value: value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))
            queryItems.append(queryItem)
        }
        urlComponents.queryItems = queryItems
        return urlComponents.url?.absoluteString
    }
    
}
