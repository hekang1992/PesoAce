//
//  PLAAFNetWorkManager.swift
//  PesoAce
//
//  Created by apple on 2024/8/4.
//

import UIKit
import HandyJSON
import Alamofire

//- 接口文档：http://8.222.151.243:8091/php_peso_ace_ios/
//- 混淆转义地址: http://8.222.151.243:8091/decode.php#
//- 混淆key：php_peso_ace_ios
//- h5地址: http://8.220.140.28
//- api地址: http://8.220.140.28/aceapi
//- ui地址：
//- 万能验证码：202406
//- 测试账号： 9111222301 ~ 9111222333


let baseUrl = "http://8.220.140.28/aceapi"

class PLAAFNetWorkManager: NSObject {

    static let shared = PLAAFNetWorkManager()
    
    typealias CompleteBlock = (_ baseModel: BaseModel) -> Void
    
    typealias NSErrorBlock = (_ error: Any) -> Void
    
    let headers: HTTPHeaders = [
        "Accept": "application/json;",
        "Connection": "keep-alive",
        "Content-Type": "application/x-www-form-urlencoded;text/javascript;text/plain;multipart/form-data"]
    
    func requestAPI(params: [String: Any]?,
                    pageUrl: String,
                    method: HTTPMethod,
                    complete: @escaping CompleteBlock,
                    errorBlock: @escaping NSErrorBlock){
        AF.sessionConfiguration.timeoutIntervalForRequest = 30
        if let requestUrl = createRequsetURL(baseURL: baseUrl + pageUrl, params: PLALoginFactory.getLoginParas()) {
            AF.request(requestUrl, method: method, parameters: params, headers: headers).responseData { response in
                switch response.result {
                case .success(let success):
                    if response.data == nil {
                        return
                    }
                    let jsonStr = NSString(data:response.data! ,encoding: String.Encoding.utf8.rawValue)
                    let model = JSONDeserializer<BaseModel>.deserializeFrom(json: jsonStr as String?)
                    if let model = model {
                        if model.greasy == -2 {
                            complete(model)
                        }else{
                            complete(model)
                        }
                    }else {
                        errorBlock("failure")
                    }
                    break
                case .failure(let failure):
                    errorBlock(failure)
                    break
                }
            }
        }
    }
    
    func uploadImageAPI(params: [String: Any]?,
                        pageUrl: String,
                        method: HTTPMethod,
                        data: Data,
                        complete: @escaping CompleteBlock,
                        errorBlock: @escaping NSErrorBlock){
        AF.sessionConfiguration.timeoutIntervalForRequest = 30
        if let requestUrl = createRequsetURL(baseURL: baseUrl + pageUrl, params: PLALoginFactory.getLoginParas()) {
            AF.upload(
                multipartFormData: { multipartFormData in
                    multipartFormData.append(data, withName: "impact", fileName: "impact.png", mimeType: "image/png")
                    if let params = params {
                        for (key, value) in params {
                            let value :String! = value as? String
                            multipartFormData.append(value.data(using: .utf8)!, withName: key)
                        }
                    }
                },
                to: requestUrl,headers: headers)
            .validate()
            .responseData(completionHandler: { response in
                switch response.result {
                case .success(let success):
                    if response.data == nil {
                        return
                    }
                    let jsonStr = NSString(data:response.data! ,encoding: String.Encoding.utf8.rawValue)
                    let model = JSONDeserializer<BaseModel>.deserializeFrom(json: jsonStr as String?)
                    if let model = model {
                        complete(model)
                    }else {
                        errorBlock("failure")
                    }
                    break
                case .failure(let failure):
                    errorBlock(failure)
                    break
                }
            })
        }
        
    }
    
    func uploadDataAPI(params: [String: Any]?,
                       pageUrl: String,
                       method: HTTPMethod,
                       complete: @escaping CompleteBlock,
                       errorBlock: @escaping NSErrorBlock){
        AF.sessionConfiguration.timeoutIntervalForRequest = 30
        if let requestUrl = createRequsetURL(baseURL: baseUrl + pageUrl, params: PLALoginFactory.getLoginParas()) {
            AF.upload(
                multipartFormData: { multipartFormData in
                    if let params = params {
                        for (key, value) in params {
                            let value :String! = value as? String
                            multipartFormData.append(value.data(using: .utf8)!, withName: key)
                        }
                    }
                },
                to: requestUrl,headers: headers)
            .validate()
            .responseData(completionHandler: { response in
                switch response.result {
                case .success(let success):
                    if response.data == nil {
                        return
                    }
                    let jsonStr = NSString(data:response.data! ,encoding: String.Encoding.utf8.rawValue)
                    let model = JSONDeserializer<BaseModel>.deserializeFrom(json: jsonStr as String?)
                    if let model = model {
                        complete(model)
                    }else {
                        errorBlock("failure")
                    }
                    break
                case .failure(let failure):
                    errorBlock(failure)
                    break
                }
            })
        }
    }
}


extension PLAAFNetWorkManager {
    
    func createRequsetURL(baseURL: String, params: [String: String]) -> String? {
        guard var urlComponents = URLComponents(string: baseURL) else {
            return nil
        }
        var queryItems = [URLQueryItem]()
        for (key, value) in params {
            let queryItem = URLQueryItem(name: key, value: value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))
            queryItems.append(queryItem)
        }
        urlComponents.queryItems = queryItems
        return urlComponents.url?.absoluteString
    }
    
}
