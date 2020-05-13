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
        // MARK:- Work with your original URL, some JS not working on webview html
        if let path = Bundle.main.url(forResource: "landingpage", withExtension: "html"){
            let myURLRequest:URLRequest = URLRequest(url: path)
            webView!.load(myURLRequest)
        }
        self.view.addSubview(webView!)
    }
    

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        /* this is for calling backtoapp js function if you get result in JSON then fine */
        webView.evaluateJavaScript("backtoapp()", completionHandler: { (result, error) in
            if error == nil {
                if result != nil {
                    print(result as Any)
                }
            } else {
                print(error as Any)
            }
        })
        //  Else you can get text for this div and can play with them
        webView.evaluateJavaScript("document.body.innerText") { (result, error) in
            print(result as Any)
        }
    }
}


