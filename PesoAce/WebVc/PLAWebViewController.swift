//
//  PLAWebViewController.swift
//  PesoAce
//
//  Created by apple on 2024/8/12.
//

import UIKit
import WebKit
import RxSwift
import StoreKit
import MBProgressHUD_WJExtension

class PLAWebViewController: PLABaseViewController {
    
    var type: String?
    
    var productUrl: String?
    
    private let disposeBag = DisposeBag()
    
    // Lazy-loaded back button
    private lazy var backButton: EXButton = {
        let button = EXButton(type: .custom)
        button.hitTestEdgeInsets = UIEdgeInsets(top: -10.px(), left: -10.px(), bottom: -10.px(), right: -10.px())
        button.setBackgroundImage(UIImage(named: "backimage"), for: .normal)
        return button
    }()
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel.createLabel(font: UIFont(name: regular_font, size: 14.px())!, textColor: UIColor.init(css: "#2D2D2D"), textAlignment: .center)
        return titleLabel
    }()
    
    lazy var topView: UIView = {
        let topView = UIView()
        topView.backgroundColor = .white
        return topView
    }()
    
    // Lazy-loaded WKWebView with necessary configuration
    private lazy var webView: WKWebView = {
        let configuration = WKWebViewConfiguration()
        let userContentController = WKUserContentController()
        let scriptNames = ["toOccasion", "partlyDissipated", "flightEven", "toEscape", "drewHerDown", "faceToBurn", "HeaderType"]
        scriptNames.forEach { userContentController.add(self, name: $0) }
        configuration.userContentController = userContentController
        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.scrollView.bounces = false
        webView.scrollView.alwaysBounceVertical = false
        webView.scrollView.showsVerticalScrollIndicator = false
        webView.scrollView.showsHorizontalScrollIndicator = false
        webView.scrollView.contentInsetAdjustmentBehavior = .never
        webView.navigationDelegate = self
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.title), options: .new, context: nil)
        return webView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadProductUrl()
        setupion()
        print("URL>>>>>>>>>: \(productUrl ?? "")")
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == #keyPath(WKWebView.title) {
            if let llitle = change?[.newKey] as? String {
                DispatchQueue.main.async { [weak self] in
                    self?.titleLabel.text = llitle
                }
            }
        } else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
    
    private func setupUI() {
        view.addSubview(webView)
        view.addSubview(topView)
        view.addSubview(backButton)
        view.addSubview(titleLabel)
        topView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(DeviceStatusHeightManager.statusBarHeight + 44.px())
        }
        backButton.snp.makeConstraints { make in
            make.bottom.equalTo(topView.snp.bottom).offset(-14.px())
            make.size.equalTo(CGSize(width: 19.px(), height: 19.px()))
            make.left.equalToSuperview().offset(28.px())
        }
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(topView.snp.bottom).offset(-10.px())
            make.height.equalTo(24.px())
        }
        webView.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    private func loadProductUrl() {
        guard let productUrl = productUrl?.replacingOccurrences(of: " ", with: "%20"),
              let url = URL(string: productUrl) else { return }
        webView.load(URLRequest(url: url))
    }
    
    private func setupion() {
        backButton.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            if self.webView.canGoBack {
                self.webView.goBack()
            } else {
                if self.type == "moneyall" {
                    if let navigationController = self.navigationController {
                        JudgePushVcConfing.popToZhidingVc(ofClass: PLAOrderViewController.self, in: navigationController)
                    }
                } else {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }).disposed(by: disposeBag)
    }
}

extension PLAWebViewController: WKScriptMessageHandler, WKNavigationDelegate {
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        guard let method = methodMapping[message.name] else {
            print("Unknown method: \(message.name)")
            return
        }
        method(message.body as? [String])
    }
    
    private var methodMapping: [String: ([String]?) -> Void] {
        return [
            "toOccasion": { url in
                self.uploadmian(url)
            },
            "partlyDissipated": { url in
                self.daikaiwangzhi(url)
            },
            "drewHerDown": { url in
                self.callhod(url)
            },
            "HeaderType": { url in
                self.bgcolor(url)
            },
            "faceToBurn": { _ in self.toapprank() },
            "flightEven": { _ in self.closeyemian() },
            "toEscape": { _ in self.toHome() }
        ]
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        ViewHud.hideLoadView()
        guard let url = navigationAction.request.url else {
            decisionHandler(.allow)
            return
        }
        let urlStr = url.absoluteString
        if urlStr.hasPrefix("mailto:") || urlStr.hasPrefix("whatsapp:") {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else if urlStr.hasPrefix("whatsapp:") {
                MBProgressHUD.wj_showPlainText("Please install WhatsApp first.", view: nil)
            }
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 60) {
            ViewHud.hideLoadView()
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        ViewHud.hideLoadView()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        ViewHud.hideLoadView()
    }
    
    // MARK: - Action Methods
    
    private func closeyemian() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func toHome() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    private func callhod(_ arguments: [String]?) {
        guard let leixingzifu = arguments?.first else { return }
        if leixingzifu.hasPrefix("PesoAceP://") {
            if let range = leixingzifu.range(of: "PesoAceP://") {
                let phone = String(leixingzifu[range.upperBound...])
                let phoneStr = "telprompt://\(phone)"
                if let phoneURL = URL(string: phoneStr), UIApplication.shared.canOpenURL(phoneURL) {
                    UIApplication.shared.open(phoneURL, options: [:], completionHandler: nil)
                }
            }
        }else if leixingzifu.hasPrefix("PesoAceM://"){
            if let range = leixingzifu.range(of: "PesoAceM://") {
                let emailAddress = String(leixingzifu[range.upperBound...])
                let mobileStr = UserDefaults.standard.object(forKey: PLA_LOGIN)
                let phoneStr = "PesoAce: \(mobileStr ?? "")"
                if let emailURL = URL(string: "mailto:\(emailAddress)?body=\(phoneStr)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!) {
                    if UIApplication.shared.canOpenURL(emailURL) {
                        UIApplication.shared.open(emailURL, options: [:], completionHandler: nil)
                    }
                }
            }
        }
    }
    
    private func toapprank() {
        if #available(iOS 14.0, *) {
            if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                SKStoreReviewController.requestReview(in: scene)
            }
        } else {
            SKStoreReviewController.requestReview()
        }
    }
    
    private func daikaiwangzhi(_ arguments: [String]?) {
        guard let path = arguments?.first else { return }
        JudgeConfig.judue(path, "", from: self)
    }
    
    private func bgcolor(_ arguments: [String]?) {
        guard let path = arguments?.first else { return }
        if path == "0" {
            normalConf()
            self.topView.backgroundColor = .white
        } else if path == "1" {
            self.backButton.setBackgroundImage(UIImage(named: "Groupbaisejiantou"), for: .normal)
            self.titleLabel.textColor = .white
            self.topView.backgroundColor = UIColor.init(css: "#2681FB")
        } else if path == "2" {
            normalConf()
            self.topView.backgroundColor = UIColor.init(css: "#EEF4FA")
        }else {
            normalConf()
            self.topView.alpha = 0
            self.webView.snp.remakeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
    }
    
    func normalConf() {
        self.backButton.setBackgroundImage(UIImage(named: "backimage"), for: .normal)
        self.titleLabel.textColor = UIColor.init(css: "#2D2D2D")
    }
    
    private func uploadmian(_ arguments: [String]?) {
        guard let productId = arguments?.first, arguments?.count ?? 0 >= 2 else { return }
        let startTime = arguments![1]
        JudgeConfig.maidianxinxi(productId, "10", startTime, DeviceInfo.getCurrentTime()) {
            
        }
    }
    
}
