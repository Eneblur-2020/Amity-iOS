//
//  ViewController.swift
//  Amity
//
//  Created by swapna raddi on 15/05/20.
//  Copyright © 2020 Eneblur Consulting. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    @IBOutlet weak var phoneNum: UIButton!
    @IBOutlet weak var email: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        phoneNum.layer.cornerRadius = 5
        email.layer.cornerRadius = 5
        
        
        
    }
    @IBAction func phoneNumberButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "onPhoneNumPressed", sender: self)
       
    }
    
    @IBAction func EmailButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "onEmailBtnClick", sender: self)
    }
    
    @IBAction func alreadyHaveAnAccountBtnPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "alreadyHaveAnAccountPressed", sender: self)
    }
}
