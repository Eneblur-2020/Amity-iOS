//
//  SignUpUsingPhoneNumViewController.swift
//  Amity
//
//  Created by swapna raddi on 21/05/20.
//  Copyright © 2020 Eneblur Consulting. All rights reserved.
//

import UIKit
import Toaster

class CellClass: UITableViewCell{
    
}
var isFromSignUp = 0
class SignUpUsingPhoneNumViewController: BaseViewController {
    @IBOutlet weak var continueBtn: UIButton!
    @IBOutlet weak var accountBtn: UIButton!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var phoneNmbrErrLabel: UILabel!
    @IBOutlet weak var selectCountryCode: UIButton!
    
    //    let transparentView = UIView()
    //    let tableView = UITableView()
    //
    //    var selectedButton = UIButton()
    //    var dataSource = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetUp()
        
        
        //        tableView.dataSource = self
        //        tableView.delegate = self
        //        tableView.register(CellClass.self, forCellReuseIdentifier: "Cell")
    }
    func initialSetUp(){
        self.phoneNumber.delegate = self
        self.phoneNumber.keyboardType = .numberPad
        selectCountryCode.layer.borderWidth = 1
        selectCountryCode.layer.borderColor = UIColor.lightGray.cgColor
        continueBtn.layer.cornerRadius = 5
    }
    
    @IBAction func onContinueBtnPressed(_ sender: Any) {
        if (validateTextFields()){
            self.SignUpUsingPhone(url: SIGNUP_MOBILE_API)
        }
    }
    
    @IBAction func onAccountBtnPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "accountBtnClicked", sender: self)
    }
    
    @IBAction func onBackPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    func SignUpUsingPhone(url :String){
        startActivityIndicator()
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "POST"
        
        var indata: [String: Any] = ["contactNumber":"1234567","countryCode":"+91"]
        indata["contactNumber"] =  phoneNumber.text
        indata["countryCode"] = "+91"
        
        if let json = try? JSONSerialization.data(withJSONObject : indata, options: []){
            if let content = String(data: json, encoding: String.Encoding.utf8){
                // here `content` is the JSON dictionary containing the String
                print(content)
                request.httpBody = content.data(using: String.Encoding.utf8)
            }
        }
        print(request.httpBody as Any)
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            guard error == nil && data != nil else {      // check for fundamental networking error
                print("error=\(String(describing: error))")
                return
            }
            
            do {
                if let responseJSON = try JSONSerialization.jsonObject(with: data!) as? [String:AnyObject]{
                    self.stopActivityIndicator()
                    
                    let response1 = responseJSON["status"]! as! Int
                    let response2 = responseJSON["message"]! as! String
                    
                    
                    
                    //Check response from the sever
                    if (response1 == 200)
                    {
                        OperationQueue.main.addOperation {
                            
                            //API call Successful and can perform other operatios
                            self.performSegue(withIdentifier: "OTPSegue", sender: self)
                            isFromSignUp = 1
                            Toast(text: "OTP send successFully", duration: Delay.short)
                            print("SignUp Successful")
                        }
                        
                    }
                    else if (response1 == 300){
                        OperationQueue.main.addOperation {
                            let alert = UIAlertController(title:"", message: response2, preferredStyle: UIAlertController.Style.alert)
                            alert.addAction(UIAlertAction(title: "OK", style:.default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                            print("Failed to send OTP")
                        }
                    }
                        
                    else
                    {
                        OperationQueue.main.addOperation {
                            
                            //API call failed and perform other operations
                            print("SignUp Failed")
                            
                        }
                        
                    }
                    
                }
            }
            catch {
                print("Error -> \(error)")
            }
            
        }
        
        
        task.resume()
    }
    
    //Phone Number validation
    func validatePhoneNum(value: String) -> Bool {
        let PHONE_REGEX = "^\\d{3}-\\d{3}-\\d{4}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: value)
        return result
    }
    
    //    func isValidMobileNo(value:String) -> Bool {
    //        let PHONE_REGEX = "^[7-9][0-9]{9}$";
    //        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
    //        let result =  phoneTest.evaluate(with: self)
    //        return result
    //    }
    
    func validateTextFields() -> Bool {
        
        let phone = phoneNumber.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if(phone!.isEmpty){
            phoneNmbrErrLabel.alpha = 1
        }
        else if(!validatePhoneNum(value: phoneNumber.text!)) {
            phoneNmbrErrLabel.text = "Enter valid mobile number"
            phoneNmbrErrLabel.alpha = 1
            
        }
        else {
            phoneNmbrErrLabel.alpha = 0
        }
        
        if (phone?.count == 10){
            phoneNmbrErrLabel.alpha = 0
            return true
        }
        else {
            return false
        }
    }
    
    
    //    func addTransparentView(frames: CGRect) {
    //        let window = UIApplication.shared.keyWindow
    //        transparentView.frame = window?.frame ?? self.view.frame
    //        self.view.addSubview(transparentView)
    //
    //        tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
    //        self.view.addSubview(tableView)
    //        tableView.layer.cornerRadius = 5
    //
    //        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
    //        tableView.reloadData()
    //        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(removeTransparentView))
    //        transparentView.addGestureRecognizer(tapgesture)
    //        transparentView.alpha = 0
    //        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
    //            self.transparentView.alpha = 0.5
    //            self.tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height + 5, width: frames.width, height: CGFloat(self.dataSource.count * 50))
    //    },completion: nil)
    //}
    //
    //    @objc func removeTransparentView(){
    //        let frames = selectedButton.frame
    //        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
    //            self.transparentView.alpha = 0
    //            self.tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
    //        }, completion: nil)
    //    }
    //
    //
    //    @IBAction func selectCountryCodeBtnClick(_ sender: Any) {
    //        dataSource = ["+91","+71","+41"]
    //        selectedButton = selectCountryCode
    //        addTransparentView(frames: selectCountryCode.frame)
    //    }
    //}
    
    
    
}
extension SignUpUsingPhoneNumViewController: UITextFieldDelegate{
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for txt in self.view.subviews {
            if txt.isKind(of: UITextField.self) && txt.isFirstResponder {
                txt.resignFirstResponder()
            }
        }
    }
}


