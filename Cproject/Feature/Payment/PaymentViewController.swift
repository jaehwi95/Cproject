//
//  PaymentViewController.swift
//  Cproject
//
//  Created by Jaehwi Kim on 2024/08/08.
//

import UIKit
import WebKit

final class PaymentViewController: UIViewController {
    private var webView: WKWebView?
    private var getMessageScriptName: String = "receiveMessage"
    private var getPaymentScriptName: String = "paymentComplete"
    
    override func loadView() {
        let contentController = WKUserContentController()
        // HTML의 window.webkit.messageHandlers.receiveMessage.postMessage... 이름은 웹 개발자와 소통하여 맞춤
        contentController.add(self, name: getMessageScriptName)
        contentController.add(self, name: getPaymentScriptName)
        
        let config = WKWebViewConfiguration()
        config.userContentController = contentController
        
        webView = WKWebView(frame: .zero, configuration: config)
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadWebView()
        setUserAgent()
        setCookie()
        
        let button: UIButton = UIButton(frame: CGRect(x: 0, y: 100, width: 100, height: 100))
        button.setTitle("Call JavaScript", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addAction(UIAction(handler: { [weak self] _ in
            self?.callJavaScript()
        }), for: .touchUpInside)
        view.addSubview(button)
    }
    
    private func loadWebView() {
        guard let htmlPath = Bundle.main.path(forResource: "test", ofType: "html") else {
            return
        }
        let url = URL(fileURLWithPath: htmlPath)
        var request = URLRequest(url: url)
        // Custom Header 추가
        request.addValue("customValue", forHTTPHeaderField: "Header-Name")
        
        
        webView?.load(request)
    }
    
    private func setUserAgent() {
        webView?.customUserAgent = "Cproject/1.0.0/iOS/"
    }
    
    private func setCookie() {
        // 보안성이 강화되면서 해당 도메인에 맞는 쿠키만 사용 가능
        guard let cookie = HTTPCookie(properties: [
            .domain: "google.co.kr",
            .path: "/",
            .name: "myCookie",
            .value: "value",
            .secure: "FALSE",
            .expires: NSDate(timeIntervalSinceNow: 3600),
        ]) else { return }
        webView?.configuration.websiteDataStore.httpCookieStore.setCookie(cookie)
    }
    
    private func callJavaScript() {
        webView?.evaluateJavaScript("javascriptFunction();")
    }
}

extension PaymentViewController: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == getMessageScriptName {
            print("\(message.body)")
        } else if message.name == getPaymentScriptName {
            print("\(message.body)")
        }
    }
}

#Preview {
    PaymentViewController()
}
