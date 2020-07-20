//
//  RegisterDetailViewController.swift
//  Amity
//
//  Created by Vinayak Tudayekar on 19/07/20.
//  Copyright © 2020 Eneblur Consulting. All rights reserved.
//

import UIKit
import WebKit

class RegisterDetailViewController: BaseViewController {
    @IBOutlet weak var registerWebView: WKWebView!
    var registerURL: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetUp()
        
    }
    func initialSetUp(){
        
        registerWebView.navigationDelegate = self
        self.title = "Amity Future Academy"
        startActivityIndicator()
        let requestURL = URL(string: registerURL ?? "")
        let request = URLRequest(url: requestURL!)
        registerWebView.load(request)
        
    }
    
    
}
extension RegisterDetailViewController: WKNavigationDelegate{
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        stopActivityIndicator()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        stopActivityIndicator()
    }
}
