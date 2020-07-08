//
//  OTPVarificationViewController.swift
//  Amity
//
//  Created by swapna raddi on 29/05/20.
//  Copyright © 2020 Eneblur Consulting. All rights reserved.
//

import UIKit
import Alamofire

class OTPVarificationViewController: UIViewController {
    @IBOutlet weak var otpTextField: UITextField!
    @IBOutlet weak var continueButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        continueButton.layer.cornerRadius = 5
    }
    
    @IBAction func onContinueBtnPressed(_ sender: Any) {
        self.OTPVerification(url:VERIFY_MOBILE_OTP )
    }
    
    @IBAction func onBackBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //Call API OTP Varification
    func OTPVerification(url:String){
        
        let data : [String : String] =
            ["code" : otpTextField.text ?? ""]
        
        if isInternetAvailable(){
            Util.Manager.request(url, method : .post,  parameters: data, encoding: JSONEncoding.default).responseJSON { (response) in
                switch response.result{
                case .success(_):
                    if let json = response.result.value{
                        if let jsonData = json as? NSDictionary {
                            if let status = jsonData.object(forKey: "status") as? Int {
                                if status == 200 {
                                if isFromOTPSegue == 1 { self.performSegue(withIdentifier: "otpToTabbar", sender: self)
                                                               isFromOTPSegue = 0
                                                           }else if isFromOTPSegue == 2{
                                                               self.performSegue(withIdentifier: "otpToResetPassword", sender: self)
                                                               isFromOTPSegue = 0
                                                           }
                                                           
                                }
                            }
                        }
                    }
                    break
                case .failure(_):
                    if let statusCode = response.response?.statusCode {
                        
                    }
                    break
                    
                }
            }
        } else {
            Util.showWhistle(message: NO_INTERNET, viewController: self)
        }
        
    }
    
}
   
