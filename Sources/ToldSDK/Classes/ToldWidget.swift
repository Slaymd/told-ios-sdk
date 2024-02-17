//
//  ToldWidget.swift
//  ToldSDK
//
//  Created by Darius MARTIN on 26/04/2023.
//

#if !os(macOS)

import UIKit
import WebKit
import SafariServices

internal class ToldWidget: UIView, WKNavigationDelegate, WKScriptMessageHandler {
    
    // Widget variables
    private var surveyId: String
    private var projectId: String
    private var mode: ToldWidgetMode
    private var closeCallback: (_ replied: Bool) -> Void
    
    
    // UI variables
    private var webView: WKWebView!
    private var heightConstraint: NSLayoutConstraint?
    private var superHeightConstraint: NSLayoutConstraint?
    private var widgetHeightValue: CGFloat = 500
    
    // MARK: Init
    
    init(surveyId: String, projectId: String, mode: ToldWidgetMode, closeCallback: @escaping (_ replied: Bool) -> Void) {
        self.surveyId = surveyId
        self.projectId = projectId
        self.mode = mode
        self.closeCallback = closeCallback
                
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setup() {
        
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
        
        webView.isOpaque = false
        
        webView.alpha = 0.0
        self.addSubview(webView)
        self.bringSubview(toFront: webView)
    
        // Add style constraint
        self.heightConstraint = webView.heightAnchor.constraint(equalToConstant: 220)
        heightConstraint!.isActive = true
        
        self.superHeightConstraint = self.heightAnchor.constraint(equalToConstant: 220)
        superHeightConstraint!.isActive = true
        
        if let superview = superview {
            
            translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                leadingAnchor.constraint(equalTo: superview.leadingAnchor),
                trailingAnchor.constraint(equalTo: superview.trailingAnchor),
                bottomAnchor.constraint(equalTo: superview.bottomAnchor),
                superHeightConstraint!
            ])
        }
      
        NSLayoutConstraint.activate([
            webView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            webView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            webView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            heightConstraint!,
        ])
        
        webView.layer.cornerRadius = 25.0
        webView.layer.masksToBounds = true
        
        webView.isHidden = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        loadWidget()
    }
    
    // MARK: Public methods
    
    public func loadWidget() {
        let hasHiddenFields = Told.currentHiddenFieldsFormatted.count > 0
        let hiddenFieldsQueryURL = hasHiddenFields ? "&\(Told.currentHiddenFieldsFormatted)" : ""
        
        if let url = URL(string: "\(Told.WIDGET_URL)/?id=\(self.surveyId)&toldProjectID=\(self.projectId)\(hiddenFieldsQueryURL)") {
            webView.load(URLRequest(url: url))
        }
    }
    
    public func close() {
        NotificationCenter.default.removeObserver(self)
        UIView.transition(with: webView, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.webView.alpha = 0.0
        }) { _ in
            self.webView.isHidden = true
            self.removeFromSuperview()
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
            
            let safeAreaBottomHeight = self.safeAreaInsets.bottom
            
            self.webView.evaluateJavaScript("window.postMessage({type: 'SAFE_AREA', value: '\(safeAreaBottomHeight)'}, '*');")
            
            self.heightConstraint?.constant = 220 + safeAreaBottomHeight
            self.superHeightConstraint?.constant = 220 + safeAreaBottomHeight
            break
        case "LAUNCH_CALENDAR":
            guard let value = values["value"] as? Dictionary<String,Any> else { return }
            guard let iframeUrl = value["iframeUrl"] as? String else { return }
            
            guard let url = URL(string: iframeUrl) else { return }
            let svc = SFSafariViewController(url: url)
            Told.currentViewController?.present(svc, animated: true)
        case "UPDATE_SIZE":
//            guard let value = values["value"] as? String else {
//                return;
//            }
//                        
//            if (value != "openMobile") {
//                break
//            }
//
//            UIView.transition(with: webView, duration: 0.7, options: .curveEaseIn, animations: {
//                var screenHeight = CGFloat(500)
//                if #available(iOS 13.0, *) {
//                    screenHeight = self.window?.windowScene?.screen.bounds.height ?? 500
//                } else {
//                    screenHeight = UIScreen.main.bounds.height
//                }
//                self.heightConstraint?.constant = screenHeight * 0.9
//                self.superHeightConstraint?.constant = screenHeight * 0.9
//            }, completion: nil)

            break
        case "HEIGHT_CHANGE":
            guard let value = values["value"] as? Int else {
                return;
            }
            
            let screenHeight = ToldUtils.getScreenHeight(widget: self)
            let maxHeight = screenHeight * 0.9
            let newWidgetHeight = value > Int(maxHeight) ? maxHeight : CGFloat(value)
            
            // Animate when widget increase its size
            let animated = self.widgetHeightValue < newWidgetHeight
            
            self.widgetHeightValue = newWidgetHeight
            
            updateWebviewHeight(height: newWidgetHeight, animated: animated)
            break
        case "ADD_COOKIE":
            guard let reply = values["reply"] as? Bool else {
                return;
            }
            self.closeCallback(reply)
            break
        case "CLOSE":
            close()
            break
        default:
            break
        }
    }
    
    // MARK: Private methods
    private func updateWebviewHeight(height: CGFloat, animated: Bool = true) {
        let calculatedHeight = height < 220 ? 220 : height
        
        self.heightConstraint?.constant = calculatedHeight
        self.superHeightConstraint?.constant = calculatedHeight
        
        if (animated) {
            UIView.animate(withDuration: 0.3) {
                self.webView.layoutIfNeeded()
                self.superview?.layoutIfNeeded()
            }
        } else {
            self.superview?.layoutIfNeeded()
        }

    }
    
    
    // MARK: Keyboard listeners
    
    @objc func keyboardWillAppear() {
        let screenHeight = ToldUtils.getScreenHeight(widget: self)
        let maxHeight = screenHeight * 0.9
        
        updateWebviewHeight(height: maxHeight)
    }

    @objc func keyboardWillDisappear() {
        updateWebviewHeight(height: widgetHeightValue)
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
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let urlStr = navigationAction.request.url?.absoluteString, navigationAction.navigationType == .linkActivated {
            guard let url = URL(string: urlStr) else { return }
            let svc = SFSafariViewController(url: url)
            Told.currentViewController?.present(svc, animated: true)
        }
        decisionHandler(.allow)
    }
    
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

#endif