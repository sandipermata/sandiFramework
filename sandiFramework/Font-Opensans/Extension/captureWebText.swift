//
//  captureWebText.swift
//  SJIalmofire
//
//  Created by adriansalim on 23/04/20.
//  Copyright © 2020 adriansalim. All rights reserved.
//

import UIKit
import WebKit

public class captureWebText: UIViewController, WKNavigationDelegate, WKScriptMessageHandler {
    private var webView: WKWebView!
    private var webViewContentIsLoaded = false
    
    var urlCustom = String()
    var javaScriptCustom = String()
    var arrCheck = [String]()
    var speratedArr = [String]()
    var counterInt = Int()
    var javascript = String()
    
    public init(urlCustom: String, javaScriptCustom: String) {
        super.init(nibName: nil, bundle: nil)
        let contentController = WKUserContentController()
        contentController.add(self as WKScriptMessageHandler, name: "callbackHandler")
        
        self.webView = {
            
            let preferences = WKPreferences()
            preferences.javaScriptEnabled = true
            
            contentController.add(self, name: "WebViewControllerMessageHandler")
            
            let configuration = WKWebViewConfiguration()
            configuration.userContentController = contentController
            configuration.preferences = preferences
            
            let webView = WKWebView(frame: .zero, configuration: configuration)
            webView.scrollView.bounces = false
            webView.navigationDelegate = self
            
            return webView
        }()
        
        self.javaScriptCustom = javaScriptCustom
        self.urlCustom = urlCustom
        self.javascript = "var outerHTML = \(javaScriptCustom)\n" +
            "var message = {\"type\": \"outerHTML\", \"outerHTML\": outerHTML }\n" +
        "window.webkit.messageHandlers.WebViewControllerMessageHandler.postMessage(message)\n"
        
        if !webViewContentIsLoaded {
            let url = URL(string: urlCustom)!
            let request = URLRequest(url: url)
            
            webView.load(request)
            
            webViewContentIsLoaded = true
        }
        
    }
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    private func evaluateJavascript(_ javascript: String, sourceURL: String? = nil, completion: ((_ error: String?) -> Void)? = nil) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
            var javascript = javascript
            
            if let sourceURL = sourceURL {
                javascript = "//# sourceURL=\(sourceURL).js\n" + javascript
            }
            self.webView.evaluateJavaScript(javascript) { (result, error) in}
        }
        
        
    }
    
    // MARK: - WKNavigationDelegate
    
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // This must be valid javascript!  Critically don't forget to terminate statements with either a newline or semicolon!
        evaluateJavascript(javascript, sourceURL: "getOuterHMTL")
        
        
    }
    
    public func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        self.setDataArr(message: message)
        
        return
    }
    
    private func setDataArr(message: WKScriptMessage){
        let dataWebsite = message.body as! NSDictionary
        let dataAll = [dataWebsite .object(forKey: "outerHTML")!] as NSArray
        let getFirstArr = [dataAll .object(at: 0)] as NSArray
        let getStringFromArr = getFirstArr[0] as! String
        if(getStringFromArr != ""){
            self.speratedArr = getStringFromArr.components(separatedBy: ",")
            self.arrCheck = self.speratedArr
            NotificationCenter.default.post(name: Notification.Name("passingDataSpeedTest"), object: self.arrCheck)
            if(self.arrCheck.count == 7){
                if(self.speratedArr[6] != "4"){
                    self.evaluateJavascript(self.javascript, sourceURL: "getOuterHMTL")
                }
            }
            else{
                self.evaluateJavascript(self.javascript, sourceURL: "getOuterHMTL")
            }
        }
        else{
            self.evaluateJavascript(self.javascript, sourceURL: "getOuterHMTL")
        }
    }
    
}

extension Array where Element: Comparable {
    func containsSameElements(as other: [Element]) -> Bool {
        return self.count == other.count && self.sorted() == other.sorted()
    }
}

