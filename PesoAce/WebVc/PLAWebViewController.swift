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
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setBackgroundImage(UIImage(named: "backimage"), for: .normal)
        return button
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
        return webView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        loadProductUrl()
        setupBackButtonAction()
        print("URL>>>>>>>>>: \(productUrl ?? "")")
    }
    
    private func setupUI() {
        view.addSubview(webView)
        view.addSubview(backButton)
        
        webView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: DeviceStatusHeightManager.statusBarHeight, left: 0, bottom: 0, right: 0))
        }
        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(DeviceStatusHeightManager.statusBarHeight + 14.px())
            make.left.equalToSuperview().offset(28.px())
            make.size.equalTo(CGSize(width: 16.px(), height: 16.px()))
        }
    }
    
    private func loadProductUrl() {
        guard let productUrl = productUrl?.replacingOccurrences(of: " ", with: "%20"),
              let url = URL(string: productUrl) else { return }
        webView.load(URLRequest(url: url))
    }
    
    private func setupBackButtonAction() {
        backButton.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            if self.webView.canGoBack {
                self.webView.goBack()
            } else {
                if self.type == "moneyall" {
                    self.navigationController?.popToRootViewController(animated: true)
                } else {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }).disposed(by: disposeBag)
    }
}

// MARK: - WKScriptMessageHandler, WKNavigationDelegate

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
                
            },
            "faceToBurn": { _ in self.toapprank() },
            "flightEven": { _ in self.closeSyn() },
            "toEscape": { _ in self.jumpToHome() }
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
    
    private func closeSyn() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func jumpToHome() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    private func callhod(_ arguments: [String]?) {
        guard let phone = arguments?.first else { return }
        let phoneStr = "telprompt://\(phone)"
        if let phoneURL = URL(string: phoneStr), UIApplication.shared.canOpenURL(phoneURL) {
            UIApplication.shared.open(phoneURL, options: [:], completionHandler: nil)
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
        JudgeConfig.judue(path, from: self)
    }
    
    private func uploadmian(_ arguments: [String]?) {
        guard let productId = arguments?.first, arguments?.count ?? 0 >= 2 else { return }
        let startTime = arguments![1]
        JudgeConfig.maidianxinxi(productId, "10", startTime)
    }
}
