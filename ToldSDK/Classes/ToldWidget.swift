//
//  ToldWidget.swift
//  ToldSDK
//
//  Created by Darius MARTIN on 26/04/2023.
//

import UIKit
import WebKit

internal class ToldWidget: UIViewController, WKNavigationDelegate, WKScriptMessageHandler {
    
    // Widget variables
    private var surveyId: String
    private var projectId: String
    private var mode: ToldWidgetMode
    private var closeCallback: (_ replied: Bool) -> Void
    
    
    // UI variables
    private var webView: WKWebView!
    private var heightConstraint: NSLayoutConstraint?
    
    // MARK: Init
    
    init(surveyId: String, projectId: String, mode: ToldWidgetMode, closeCallback: @escaping (_ replied: Bool) -> Void) {
        self.surveyId = surveyId
        self.projectId = projectId
        self.mode = mode
        self.closeCallback = closeCallback
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
                
        let config = WKWebViewConfiguration()
        let userContentController = WKUserContentController()

        // User script to listen postMessage in webview
        userContentController.add(self, name: "iosListener")
        userContentController.add(self, name: "logsHandler")
        
        config.userContentController = userContentController
        
        // Create webview instance
        webView = WKWebView(frame: .zero, configuration: config)
        
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.scrollView.isScrollEnabled = false
        webView.navigationDelegate = self
        
        webView.alpha = 0.0
        view.addSubview(webView)
        
        // Add style constraint
        self.heightConstraint = webView.heightAnchor.constraint(equalToConstant: 220)
        heightConstraint!.isActive = true
        
        let guide = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            webView.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: 0),
            webView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 0),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            heightConstraint!,
        ])
        
        webView.layer.cornerRadius = 25.0
        webView.layer.masksToBounds = true
        
        webView.isHidden = true
        
        loadWidget()
    }
    
    // MARK: Public methods
    
    public func loadWidget() {
        if let url = URL(string: "\(WIDGET_URL)/?id=\(self.surveyId)&toldProjectID=\(self.projectId)") {
            webView.load(URLRequest(url: url))
        }
    }
    
    public func close() {
        UIView.transition(with: webView, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.webView.alpha = 0.0
        }) { _ in
            self.webView.isHidden = true
            self.view.removeFromSuperview()
        }
    }
    
    // MARK: Private methods
    
    private func onMessageReceived(values: [String: Any]) {
        guard let type = values["type"] as? String else {
            return;
        }
        
        switch type {
        case "IS_LOADED":
            // Send initial ios configuration messages to survey
            self.webView.evaluateJavaScript("window.postMessage({type: 'OS_TYPE', value: 'IOS'}, '*'); window.postMessage({type: 'DEVICE_TYPE', value: 'phone'}, '*');")
            webView.isHidden = false
            
            UIView.transition(with: webView, duration: 0.5, options: .transitionCrossDissolve, animations: {
                self.webView.alpha = 1.0
            }, completion: nil)
            
            let safeAreaBottomHeight = view.safeAreaInsets.bottom
            
            self.webView.evaluateJavaScript("window.postMessage({type: 'SAFE_AREA', value: '\(safeAreaBottomHeight)'}, '*');")
            
            self.heightConstraint?.constant = 220 + safeAreaBottomHeight
            break
        case "UPDATE_SIZE":
            guard let value = values["value"] as? String else {
                return;
            }
                        
            if (value != "openMobile") {
                break
            }

            UIView.transition(with: webView, duration: 0.5, options: .transitionCrossDissolve, animations: {
                let frame = self.view.safeAreaLayoutGuide.layoutFrame
                self.heightConstraint?.constant = frame.height * 0.9
            }, completion: nil)

            break
        case "ADD_COOKIE":
            guard let reply = values["reply"] as? Bool else {
                return;
            }
            self.closeCallback(reply)
            break
        case "CLOSE":
            self.closeCallback(false)
            close()
            break
        default:
            break
        }
    }
    
    // MARK: WKScriptMessageHandler
    
    public func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
        guard let bodyData = message.body as? String else {
            return
        }
                
        if (message.name == "logsHandler" && mode == .debug) {
            print("[LOG]", message.body)
        } else if (message.name == "iosListener") {
            
            if (mode == .debug) {
                print("[MSG RECEIVED]", message.body)
            }

            do {
                let json = try JSONSerialization.jsonObject(with: bodyData.data(using: .utf8)!, options: [])
                if let dict = json as? [String: Any] {
                    onMessageReceived(values: dict)
                }
            } catch {
                print("Error while parsing Told received message : \(error.localizedDescription)")
            }
            
        }
    }
    
    // MARK: WKNavigationDelegate
    
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // Intercepts logs for debug mode
        self.webView.evaluateJavaScript("function captureLog(msg, other = '') { window.webkit.messageHandlers.logsHandler.postMessage(msg + other); } window.console.log = captureLog;")
                
        // Webview finished to load, inject javascript code to transfers messages to iOS SDK
        self.webView.evaluateJavaScript("window.addEventListener('message', (e) => { window.webkit.messageHandlers.iosListener.postMessage(JSON.stringify(e.data), '*'); });")
    }
    
    private func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("WebView did fail navigation with error: \(error.localizedDescription)")
    }
}
