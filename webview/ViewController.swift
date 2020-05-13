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
        // MARK:- Work with your original URL, some JS mot working on webview html
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
            let Nresult = result as? String
            let lines = Nresult!.split { $0.isNewline }
            var response = [String: String]()
            for line in self.getLast(array: lines,count: 3) {
                
                //                if line.split(separator: " ").first == "query" {
                //                    let p: String = line.split(separator: " ").last as! String
                //                    response["query"] = p
                //                }
                //                if line.split(separator: " ").first == "Policy" {
                //                    let p: String = line.split(separator: " ").last as! String
                //                    response["Policy"] = p
                //                }
                //                if line.split(separator: " ").first == "Payment" {
                //                    let p: String = line.split(separator: " ").last as! String
                //                    response["Payment"] = p
                //                }
                response["\(line.split(separator: " ").first)"] = "\(line.split(separator: " ").last)"
                print("first value ")
                print(line.split(separator: " ").first)
                print("last value ")
                print(line.split(separator: " ").last)
            }
            print(response)
        }
    }
    func getLast<T>(array: [T], count: Int) -> [T] {
        if count >= array.count {
            return array
        }
        let first = array.count - count
        return Array(array[first..<first+count])
    }
}


