//
//  SignInViewController.swift
//  Amity
//
//  Created by swapna raddi on 15/05/20.
//  Copyright © 2020 Eneblur Consulting. All rights reserved.
//

import UIKit
import Alamofire


class SignInViewController: BaseViewController {
    @IBOutlet weak var skipLabel: UILabel!
    @IBOutlet weak var continueBtn: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailErrorLabel: UILabel!
    @IBOutlet weak var passwordErrorLabel: UILabel!
    @IBOutlet weak var phoneNumberTextfield: UITextField!
    @IBOutlet weak var phoneNumberErrorLabel: UILabel!
    let userDefaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        
        continueBtn.layer.cornerRadius = 5
        emailTextField.text = "apple@mailinator.com"
        passwordTextField.text = "user1234!"
        // Label clickable
      
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(clickable))
        tapGesture.numberOfTouchesRequired = 1
       
    }
    
    @objc func clickable(){
        self.performSegue(withIdentifier: "skipNow", sender: self)
    }
    
    @IBAction func onBackPressed(_ sender: Any) {
       // self.dismiss(animated: true)
    }
    
    @IBAction func onForgotPasswordPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "forgotPassword", sender: self)
    }
    
    @IBAction func onContinueBtnClick(_ sender: Any) {
        if(validateEmailTextFields()) {
            self.SignUpUsingEmailId(url:LOGIN_EMAIL_API)
        } else if (validatePhoneTextFields()){
            self.SignUpUsingPhone(url:LOGIN_MOBILE_API )
        }
        
    }
    @IBAction func onSignUpBtnClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
     func SignUpUsingEmailId(url :String){
       
        let data : [String : String] = ["username": emailTextField.text ?? "","password": passwordTextField.text ?? ""]
        startActivityIndicator()
            if isInternetAvailable(){

                
                Util.Manager.request(url, method : .post,  parameters: data, encoding: JSONEncoding.default).responseJSON { (response) in
                    if let headerFields = response.response?.allHeaderFields as? [String: String]
                       
                    {
                        if let URL = response.request?.url{
                            let cookies = HTTPCookie.cookies(withResponseHeaderFields: headerFields, for: URL)
                            print(cookies.first)
                            print(cookies)
                            print(cookies.first?.value(forKey: "value")as! String)
                            
                             let cookieSid = cookies.first?.value(forKey: "value") as! String 
                            Util.setCookie(cookie: cookieSid)
                            self.stopActivityIndicator()
                    }
                    }
                    
                    switch response.result{
                    case .success(_):
                        if let json = response.result.value{
                            if let jsonData = json as? NSDictionary {
                                 let status = jsonData.object(forKey: "status") as? Int
                                let data = jsonData.object(forKey: "data") as? NSDictionary
                                if status == 200 {
                                    //TODO : LOCALIZATION REQUIRED
                                    
                                    self.userDefaults.set(true, forKey: "IsLoggedIn")
                                    self.performSegue(withIdentifier: "tabBarViewController", sender: self)
                                    
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
  /*  func SignUpUsingEmailId(url :String){
        
        
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "POST"
        
        
        var indata: [String: Any] = ["username":"gauuuurav","password":"Pass@123"]
        indata["username"] = emailTextField.text
        indata["password"] = passwordTextField.text

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
                //settting cookies
                
                if let responseJSON = try JSONSerialization.jsonObject(with: data!) as? [String:AnyObject]{
                    //            print(responseJSON)
                    //            print(responseJSON["status"]!)
                    //            print(responseJSON["message"]!)
                    
                    let response1 = responseJSON["status"]! as! Int
                    let response2 = responseJSON["message"]! as! String
                    let response3 = responseJSON["data"] as? NSDictionary
                    print(response3)
                    let userTokenPublicKey = response3?.value(forKey: "publicKey") as? String
                    
                    //Check response from the sever
                    if response1 == 200            {
                        OperationQueue.main.addOperation {
                            //API call Successful and can perform other operatios
                            
                            if let httpResponse = response as? HTTPURLResponse {
                                if let cookie = httpResponse.allHeaderFields["Set-Cookie"] as? String {
                                    
                                    var ck = cookie.components(separatedBy: ",")
                                    var ck1 = ck[1].components(separatedBy: ";")
                                    // use X-Dem-Auth here
                                    UserDefaults.standard.set(ck1[0], forKey: "USER")
                                }
                            }
                            self.userDefaults.set(true, forKey: "IsLoggedIn")
                            self.performSegue(withIdentifier: "tabBarViewController", sender: self)
                            
                        }
                        
                    }
                    else if(response1 == 422) {
                        OperationQueue.main.addOperation {
                            let alert = UIAlertController(title:"", message: response2, preferredStyle: UIAlertController.Style.alert)
                            alert.addAction(UIAlertAction(title: "OK", style:.default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                    else
                    {
                        OperationQueue.main.addOperation {
                            
                            //API call failed and perform other operations
                            
                            
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
 */
    func SignUpUsingPhone(url :String){
        
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "POST"
        
        var indata: [String: Any] = ["contactNumber":"1234567","countryCode":"+91"]
        indata["contactNumber"] =  phoneNumberTextfield.text
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
                    print(responseJSON)
                    print(responseJSON["status"]!)
                    print(responseJSON["message"]!)
                    
                    let response1 = responseJSON["status"]! as! Int
                    let response2 = responseJSON["message"]! as! String
                    
                    print(response1)
                    print(response2)
                    
                    //Check response from the sever
                    if (response1 == 200)
                    {
                        OperationQueue.main.addOperation {
                            
                            //API call Successful and can perform other operatios
                            isFromOTPSegue = 1
                            self.performSegue(withIdentifier: "signInToOtp", sender: self)
                            
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
    
    //Email Validation
    func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: email)
        return result
    }
    
    // Password Validation
    func isValidPassword(password: String) -> Bool {
        let passwordRegEx = "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,20}"
        let passwordTest = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        let result = passwordTest.evaluate(with: password)
        return result
    }
    //Phone Number validation
    func validatePhoneNum(value: String) -> Bool {
        let PHONE_REGEX = "^\\d{3}-\\d{3}-\\d{4}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: value)
        return result
    }
    func validateEmailTextFields() -> Bool {
        
        let email = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let pswd = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        var flag1 = 1
        
        if(email!.isEmpty){
            emailErrorLabel.alpha = 1
            flag1 = 0
        }
        else{
            emailErrorLabel.alpha = 0
        }
        if(pswd!.isEmpty){
            passwordErrorLabel.alpha = 1
            flag1 = 0
        }
        else{
            passwordErrorLabel.alpha = 0
        }
        
        if(!isValidEmail(email: emailTextField.text!)) {
            flag1 = 0
            emailErrorLabel.alpha = 1
            
        }
        else {
            emailErrorLabel.alpha = 0
        }
      
        if (flag1 == 1){
            return true
        }
        else {
            return false
        }
    }
    func validatePhoneTextFields() -> Bool {
        
        let phone = phoneNumberTextfield.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if(phone!.isEmpty){
            phoneNumberErrorLabel.alpha = 1
        }
        else if(!validatePhoneNum(value: phoneNumberTextfield.text!)) {
            phoneNumberErrorLabel.text = "Enter valid mobile number"
            phoneNumberErrorLabel.alpha = 1
            
        }
        else {
            phoneNumberErrorLabel.alpha = 0
        }
        
        if (phone?.count == 10){
            phoneNumberErrorLabel.alpha = 0
            return true
        }
        else {
            return false
        }
    }
}
