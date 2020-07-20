//
//  OTPVarificationViewController.swift
//  Amity
//
//  Created by swapna raddi on 29/05/20.
//  Copyright © 2020 Eneblur Consulting. All rights reserved.
//

import UIKit
import Alamofire

class OTPVarificationViewController: BaseViewController {
    @IBOutlet weak var otpTextField: UITextField!
    @IBOutlet weak var continueButton: UIButton!
    var isFrom :Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    func initialSetup(){
        self.otpTextField.delegate = self
        self.otpTextField.keyboardType = .numberPad
        continueButton.layer.cornerRadius = 5
        self.title = "SIGN UP"
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
        self.startActivityIndicator()
        if isInternetAvailable(){
            Util.Manager.request(url, method : .post,  parameters: data, encoding: JSONEncoding.default).responseJSON { (response) in
                self.stopActivityIndicator()
                switch response.result{
                case .success(_):
                    if let json = response.result.value{
                        if let jsonData = json as? NSDictionary {
                            let responseMessage = jsonData.object(forKey: "message") as? String
                            if let status = jsonData.object(forKey: "status") as? Int {
                                if status == 200 {
                                    if self.isFrom == 1 { //self.performSegue(withIdentifier: "otpToTabbar", sender: self)
                                       
                                        
                                        let tabBarViewController = Storyboard.Main.instance.instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
                                        tabBarViewController.modalPresentationStyle = .fullScreen
                                        self.present(tabBarViewController, animated: true, completion: nil)
                                    }else if self.isFrom == 2{
                                        self.performSegue(withIdentifier: "otpToResetPassword", sender: self)
                                       
                                    }
                                    
                                }else{
                                    OperationQueue.main.addOperation {
                                        let alert = UIAlertController(title:"", message: responseMessage, preferredStyle: UIAlertController.Style.alert)
                                        alert.addAction(UIAlertAction(title: "OK", style:.default, handler: nil))
                                        self.present(alert, animated: true, completion: nil)
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
extension OTPVarificationViewController: UITextFieldDelegate{
   override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for txt in self.view.subviews {
            if txt.isKind(of: UITextField.self) && txt.isFirstResponder {
                txt.resignFirstResponder()
            }
        }
    }
}
