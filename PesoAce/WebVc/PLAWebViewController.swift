//
//  PLAWebViewController.swift
//  PesoAce
//
//  Created by apple on 2024/8/12.
//

import UIKit
import WebKit
import RxSwift

class PLAWebViewController: PLABaseViewController {

    var productUrl: String?
    
    let disp = DisposeBag()
    
    var type: String?
    
    lazy var backBtn: UIButton = {
        let backBtn = UIButton(type: .custom)
        backBtn.setBackgroundImage(UIImage(named: "backimage"), for: .normal)
        return backBtn
    }()
    
    lazy var webView: WKWebView = {
        let configuration = WKWebViewConfiguration()
        let userContentController = WKUserContentController()
        let scriptNames = ["toOccasion", "partlyDissipated", "flightEven", "toEscape", "drewHerDown", "faceToBurn"]
        for scriptName in scriptNames {
            userContentController.add(self, name: scriptName)
        }
        configuration.userContentController = userContentController
        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.scrollView.bounces = false
        webView.scrollView.alwaysBounceVertical = false
        webView.navigationDelegate = self
        webView.scrollView.showsVerticalScrollIndicator = false
        webView.scrollView.showsHorizontalScrollIndicator = false
        webView.scrollView.contentInsetAdjustmentBehavior = .never
//        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
//        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.title), options: .new, context: nil)
        return webView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(webView)
        view.addSubview(backBtn)
        webView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: DeviceStatusHeightManager.statusBarHeight, left: 0, bottom: 0, right: 0))
        }
        backBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(DeviceStatusHeightManager.statusBarHeight + 14.px())
            make.left.equalToSuperview().offset(28.px())
            make.size.equalTo(CGSize(width: 16.px(), height: 16.px()))
        }
        if let productUrl = productUrl {
            var urlString = ""
            urlString = productUrl.replacingOccurrences(of: " ", with: "%20")
            if let url = URL(string: urlString) {
                webView.load(URLRequest(url: url))
            }
        }
        backBtn.rx.tap.subscribe(onNext: { [weak self] in
            if let canGoBack = self?.webView.canGoBack, canGoBack {
                self?.webView.goBack()
            }else {
                if self?.type == "moneyall" {
                    self?.navigationController?.popToRootViewController(animated: true)
                }else {
                    self?.navigationController?.popViewController(animated: true)
                }
            }
        }).disposed(by: disp)
    }

}

extension PLAWebViewController: WKScriptMessageHandler, WKNavigationDelegate {
    
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        ViewHud.hideLoadView()
        guard let url = navigationAction.request.url else {
            decisionHandler(.allow)
            return
        }
        let urlStr = url.absoluteString
        if urlStr.hasPrefix("mailto:") {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        } else if urlStr.hasPrefix("whatsapp:") {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
//                MBProgressHUD.show(text: "WhatsApp is not installed. Please install it.")
            }
        }
        if urlStr.hasPrefix("mailto:") || urlStr.hasPrefix("whatsapp:") {
            decisionHandler(.cancel)
        } else {
            decisionHandler(.allow)
        }
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        ViewHud.addLoadView()
        DispatchQueue.main.asyncAfter(deadline: .now() + 30) {
            ViewHud.hideLoadView()
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        ViewHud.hideLoadView()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: any Error) {
        ViewHud.hideLoadView()
    }
    
}
