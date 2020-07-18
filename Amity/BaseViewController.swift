//
//  BaseViewController.swift
//  Amity
//
//  Created by Vinayak Tudayekar on 05/07/20.
//  Copyright © 2020 Eneblur Consulting. All rights reserved.
//

import UIKit
import ANActivityIndicator
class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func startActivityIndicator() {
        
   // showIndicator()
    showIndicator(
    CGSize(width: 70, height: 70),
    message: "",
    messageFont: .none,
    messageTopMargin: nil,
    animationType: ANActivityIndicatorAnimationType.ballSpinFadeLoader,
    color: UIColor(named: "DarkBlueColour"),
    padding: nil,
    displayTimeThreshold: 3,
    minimumDisplayTime: 10)
    

        
        UIApplication.shared.beginIgnoringInteractionEvents()
        
    
    }

    func stopActivityIndicator() {
          hideIndicator()
        UIApplication.shared.endIgnoringInteractionEvents();
    }
}
