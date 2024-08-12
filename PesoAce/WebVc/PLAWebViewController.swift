//
//  PLAWebViewController.swift
//  PesoAce
//
//  Created by apple on 2024/8/12.
//

import UIKit
import WebKit

class PLAWebViewController: PLABaseViewController {

    var productUrl: String?
    
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
        webView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        if let productUrl = productUrl {
            var urlString = ""
            urlString = productUrl.replacingOccurrences(of: " ", with: "%20")
            if let url = URL(string: urlString) {
                webView.load(URLRequest(url: url))
            }
        }
    }

}

extension PLAWebViewController: WKScriptMessageHandler, WKNavigationDelegate {
    
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
    }
    
}
