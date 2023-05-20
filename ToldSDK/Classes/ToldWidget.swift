//
//  ToldModeHandler.swift
//  ToldSDK
//
//  Created by Darius MARTIN on 26/04/2023.
//

import UIKit
import WebKit

enum MODE {
    case PRODUCTION, PREVIEW, DEBUG
}

@available(iOS 11.0, *)
public class Widget: UIViewController, WKNavigationDelegate, WKScriptMessageHandler {
    
    private var webView: WKWebView!
    private var mode = MODE.PRODUCTION {
        didSet {
            
        }
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        let config = WKWebViewConfiguration()
        let userContentController = WKUserContentController()

        // Ajouter un script utilisateur pour écouter les messages
        userContentController.add(self, name: "iosListener")
        userContentController.add(self, name: "logsHandler")

//        config.preferences.javaScriptEnabled = true
//        config.preferences.javaScriptCanOpenWindowsAutomatically = true
        
        config.userContentController = userContentController
        
        // Créez une instance de WKWebView qui remplit l'écran
        webView = WKWebView(frame: .zero, configuration: config)
//        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        webView.navigationDelegate = self
        
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.scrollView.isScrollEnabled = false
        webView.navigationDelegate = self
        
        view.addSubview(webView)
        
        let guide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            webView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
            webView.heightAnchor.constraint(equalTo: guide.heightAnchor, multiplier: 0.9),
            webView.widthAnchor.constraint(equalTo: guide.widthAnchor)
        ])
        
        webView.layer.cornerRadius = 25.0
        webView.layer.masksToBounds = true
        
//        let urlStr = "https://widget.evoltapp.com/?id=643e93184e7ff9001bd4577a&toldProjectID=63a2ef43fb1f6b00156aa375"
//        let urlStr = "https://preprodwidget.evoltapp.com/?id=644248ad1261b700150b5e86&toldProjectID=644248a01261b700150b5dde"
        
        // Chargez une URL dans la WebView
//        if let url = URL(string: urlStr) {
//            webView.load(URLRequest(url: url))
//        }
        
//        if let url = URL(string: "https://google.fr/") {
//            webView.load(URLRequest(url: url))
//        }
        
        webView.isHidden = true
    }
    
    // Masquez la barre d'état lorsque la vue est chargée
    public override var prefersStatusBarHidden: Bool {
        return true
    }
    
    public func show(id: String, projectId: String) {
        if let url = URL(string: "https://preprodwidget.evoltapp.com/?id=\(id)&toldProjectID=\(projectId)") {
            webView.load(URLRequest(url: url))
        }
        webView.isHidden = false
    }
    
    public func close() {
        webView.isHidden = true
    }
    
    // MARK: WKScriptMessageHandler
    
    public func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
        guard let bodyData = message.body as? String else {
            return
        }
                
        if (message.name == "logsHandler" && mode == .DEBUG) {
            print("[LOG]", message.body)
        } else if (message.name == "iosListener") {
            print("[MSG RECEIVED]", message.body)
            
            do {
                let json = try JSONSerialization.jsonObject(with: bodyData.data(using: .utf8)!, options: [])
                if let dict = json as? [String: Any] {
                    // Utilisez le dictionnaire 'dict' ici
                    print(dict)
                }
            } catch {
                print("Erreur lors du parsing du JSON : \(error.localizedDescription)")
            }
            
        }
//        print("message body: \(message.body)")
//        print("message frameInfo: \(message.frameInfo)")
    }
    
    // MARK: WKNavigationDelegate
    
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.webView.evaluateJavaScript("function captureLog(msg, other = '') { window.webkit.messageHandlers.logsHandler.postMessage(msg + other); } window.console.log = captureLog;")
        
        // Send initial ios configuration messages to survey
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            self.webView.evaluateJavaScript("window.postMessage({type: 'OS_TYPE', value: 'IOS'}, 'https://preprodwidget.evoltapp.com/?id=644248ad1261b700150b5e86&toldProjectID=644248a01261b700150b5dde'); window.postMessage({type: 'DEVICE_TYPE', value: 'phone'}, '*');")
        }
        
        // Webview finished to load, inject javascript code to transfers messages to iOS SDK
        self.webView.evaluateJavaScript("window.addEventListener('message', (e) => { window.webkit.messageHandlers.iosListener.postMessage(JSON.stringify(e.data), '*'); });")
    }
    
    private func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("WebView did fail navigation with error: \(error.localizedDescription)")
    }
}
