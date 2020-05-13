//
//  ViewController.swift
//  webview
//
//  Created by Norat Saraswat on 12/05/20.
//  Copyright © 2020 Norat Saraswat. All rights reserved.
//

import UIKit
import WebKit
class ViewController: UIViewController,WKNavigationDelegate {
    var webView: WKWebView?
    override func viewDidLoad() {
        super.viewDidLoad()
        print("WebView Starting")
        webView = WKWebView(frame:  self.view.frame)
        webView!.navigationDelegate = self
        if let path = Bundle.main.url(forResource: "landingpage", withExtension: "html"){
            let myURLRequest:URLRequest = URLRequest(url: path)
            webView!.load(myURLRequest)
        }
        self.view.addSubview(webView!)
        self.view.sendSubviewToBack(webView!)
        
        
    }
    
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.evaluateJavaScript("backtoapp()", completionHandler: { (result, error) in
            if error == nil {
                if result != nil {
                    print(result as Any)
                }
            } else {
                print(error as Any)
            }
            
        })
        
        webView.evaluateJavaScript("document.body.innerText") { (result, error) in
            print(result as Any)
        }
        
    }
    
    
    
}


