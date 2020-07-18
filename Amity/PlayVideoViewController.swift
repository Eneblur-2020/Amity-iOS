//
//  PlayVideoViewController.swift
//  Amity
//
//  Created by Vinayak Tudayekar on 16/07/20.
//  Copyright © 2020 Eneblur Consulting. All rights reserved.
//

import UIKit
import AVKit
import WebKit

class PlayVideoViewController: BaseViewController {
    var video : Gallery?
    
    @IBOutlet weak var videoWebView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()

       initialSetUp()
       
    }
    func initialSetUp(){
        videoWebView.navigationDelegate = self
        videoWebView.backgroundColor = .clear
        self.title = "Amity Future Academy"
       startActivityIndicator()
        let requestURL = URL(string: video?.videoLink ?? "")
              let request = URLRequest(url: requestURL!)
              videoWebView.load(request)
       
    }

}
extension PlayVideoViewController: WKNavigationDelegate{
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        stopActivityIndicator()
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        stopActivityIndicator()
    }
}
