//
//  PLAAFNetWorkManager.swift
//  PesoAce
//
//  Created by apple on 2024/8/4.
//

import UIKit
import HandyJSON
import Alamofire
import RxSwift

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
    
    typealias NSErrorBlock = (_ error: Any) -> Void
    
    private let disposeBag = DisposeBag()
    
    typealias CompleteBlock = (_ baseModel: BaseModel) -> Void
    
    private let requestSubject = PublishSubject<(
        params: [String: Any]?,
        pageUrl: String,
        method: HTTPMethod,
        complete: CompleteBlock,
        errorBlock: NSErrorBlock
    )>()
    
    private let uploadImageSubject = PublishSubject<(
        params: [String: Any]?,
        pageUrl: String,
        method: HTTPMethod,
        data: Data,
        complete: CompleteBlock,
        errorBlock: NSErrorBlock
    )>()
    
    private let uploadDataSubject = PublishSubject<(
        params: [String: Any]?,
        pageUrl: String,
        method: HTTPMethod,
        complete: CompleteBlock,
        errorBlock: NSErrorBlock
    )>()
    
    let headers: HTTPHeaders = [
        "Accept": "application/json;",
        "Connection": "keep-alive",
        "Content-Type": "application/x-www-form-urlencoded;text/javascript;text/json;text/plain;multipart/form-data"
    ]
    
    override init() {
        super.init()
        requestSubject
            .throttle(.seconds(2), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] (params, pageUrl, method, complete, errorBlock) in
                self?.performRequestAPI(params: params, pageUrl: pageUrl, method: method, complete: complete, errorBlock: errorBlock)
            })
            .disposed(by: disposeBag)
        
        uploadImageSubject
            .throttle(.seconds(2), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] (params, pageUrl, method, data, complete, errorBlock) in
                self?.performUploadImageAPI(params: params, pageUrl: pageUrl, method: method, data: data, complete: complete, errorBlock: errorBlock)
            })
            .disposed(by: disposeBag)
        
        uploadDataSubject
            .throttle(.seconds(2), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] (params, pageUrl, method, complete, errorBlock) in
                self?.performUploadDataAPI(params: params, pageUrl: pageUrl, method: method, complete: complete, errorBlock: errorBlock)
            })
            .disposed(by: disposeBag)
    }
    
    func requestAPI(params: [String: Any]?,
                    pageUrl: String,
                    method: HTTPMethod,
                    complete: @escaping CompleteBlock,
                    errorBlock: @escaping NSErrorBlock) {
        requestSubject.onNext((params, pageUrl, method, complete, errorBlock))
    }
    
    func uploadImageAPI(params: [String: Any]?,
                        pageUrl: String,
                        method: HTTPMethod,
                        data: Data,
                        complete: @escaping CompleteBlock,
                        errorBlock: @escaping NSErrorBlock) {
        uploadImageSubject.onNext((params, pageUrl, method, data, complete, errorBlock))
    }
    
    func uploadDataAPI(params: [String: Any]?,
                       pageUrl: String,
                       method: HTTPMethod,
                       complete: @escaping CompleteBlock,
                       errorBlock: @escaping NSErrorBlock) {
        uploadDataSubject.onNext((params, pageUrl, method, complete, errorBlock))
    }
    
    private func performRequestAPI(params: [String: Any]?,
                                   pageUrl: String,
                                   method: HTTPMethod,
                                   complete: @escaping CompleteBlock,
                                   errorBlock: @escaping NSErrorBlock) {
        AF.sessionConfiguration.timeoutIntervalForRequest = 30
        if let requestUrl = createRequsetURL(baseURL: baseUrl + pageUrl, params: PLALoginFactory.getLoginParas()) {
            AF.request(requestUrl, method: method, parameters: params, headers: headers).responseData { response in
                switch response.result {
                case .success(_):
                    if let data = response.data {
                        let jsonStr = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
                        let model = JSONDeserializer<BaseModel>.deserializeFrom(json: jsonStr as String?)
                        if let model = model {
                            complete(model)
                        } else {
                            errorBlock("failure")
                        }
                        if let contentToSerialize = model?.wallpaper, let data = try? JSONSerialization.data(withJSONObject: contentToSerialize, options: []) {
                            let jsonString = String(data: data, encoding:.utf8)
                            print(">>>>>>>>>>>>>>>\(jsonString ?? "")")
                        }
                    }
                case .failure(let error):
                    errorBlock(error)
                }
            }
        }
    }
    
    private func performUploadImageAPI(params: [String: Any]?,
                                       pageUrl: String,
                                       method: HTTPMethod,
                                       data: Data,
                                       complete: @escaping CompleteBlock,
                                       errorBlock: @escaping NSErrorBlock) {
        AF.sessionConfiguration.timeoutIntervalForRequest = 30
        if let requestUrl = createRequsetURL(baseURL: baseUrl + pageUrl, params: PLALoginFactory.getLoginParas()) {
            AF.upload(
                multipartFormData: { multipartFormData in
                    multipartFormData.append(data, withName: "impact", fileName: "impact.png", mimeType: "image/png")
                    if let params = params {
                        for (key, value) in params {
                            if let value = value as? String {
                                multipartFormData.append(value.data(using: .utf8)!, withName: key)
                            }
                        }
                    }
                },
                to: requestUrl, headers: headers
            )
            .validate()
            .responseData { response in
                switch response.result {
                case .success(_):
                    if let data = response.data {
                        let jsonStr = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
                        let model = JSONDeserializer<BaseModel>.deserializeFrom(json: jsonStr as String?)
                        if let model = model {
                            complete(model)
                        } else {
                            errorBlock("failure")
                        }
                    }
                case .failure(let error):
                    errorBlock(error)
                }
            }
        }
    }
    
    private func performUploadDataAPI(params: [String: Any]?,
                                      pageUrl: String,
                                      method: HTTPMethod,
                                      complete: @escaping CompleteBlock,
                                      errorBlock: @escaping NSErrorBlock) {
        AF.sessionConfiguration.timeoutIntervalForRequest = 30
        if let requestUrl = createRequsetURL(baseURL: baseUrl + pageUrl, params: PLALoginFactory.getLoginParas()) {
            AF.upload(
                multipartFormData: { multipartFormData in
                    if let params = params {
                        for (key, value) in params {
                            if let value = value as? String {
                                multipartFormData.append(value.data(using: .utf8)!, withName: key)
                            }
                        }
                    }
                },
                to: requestUrl, headers: headers
            )
            .validate()
            .responseData { response in
                switch response.result {
                case .success(_):
                    if let data = response.data {
                        let jsonStr = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
                        let model = JSONDeserializer<BaseModel>.deserializeFrom(json: jsonStr as String?)
                        if let model = model {
                            complete(model)
                        } else {
                            errorBlock("failure")
                        }
                    }
                case .failure(let error):
                    errorBlock(error)
                }
            }
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
