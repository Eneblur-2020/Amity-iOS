//
//  SignUpUsingEmailViewController.swift
//  Amity
//
//  Created by swapna raddi on 21/05/20.
//  Copyright © 2020 Eneblur Consulting. All rights reserved.
//

import UIKit

class SignUpUsingEmailViewController: UIViewController {
    @IBOutlet weak var continueBtn: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmTextField: UITextField!
    @IBOutlet weak var emailErrorLabel: UILabel!
    @IBOutlet weak var pswdErrorLabel: UILabel!
    @IBOutlet weak var confirmPswdErrorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        continueBtn.layer.cornerRadius = 5
        
    }
  
    @IBAction func onContinueBtnPressed(_ sender: Any) {
        
        if (validateTextFields()){
           //self.performSegue(withIdentifier: "signUpToMyAccount", sender: self)
           self.SignUpUsingEmailId(url: SIGNUP_BY_EMAIL_API)
        }
    }
    
    @IBAction func onBackPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func accountBtnPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "alreadyHaveAccount", sender: self)
    }
    
    
    func SignUpUsingEmailId(url :String){
        
    let request = NSMutableURLRequest(url: NSURL(string: url)! as URL)
    request.httpMethod = "POST"
    
    //let postString = "email=\(String(describing: emailTextField))&password=\(passwordTextField!)&confirmPassword=\(confirmTextField!)"
        var indata: [String: Any] = ["email":"gauuuuravk@gmail.com","password":"Pass@123","confirmPassword":"Pass@123"]
        indata["email"] =  emailTextField.text
        indata["password"] = passwordTextField.text
        indata["confirmPassword"] = confirmTextField.text
                                   
       // let content : String
        //let jrequest = try? JSONSerialization.data(withJSONObject: indata,options: [])
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
                   if let httpResponse = response as? HTTPURLResponse {
                     if let xDemAuth = httpResponse.allHeaderFields["Set-Cookie"] as? String {
                        // use X-Dem-Auth here
                       print(xDemAuth)
                       }
                   }
            
        if let responseJSON = try JSONSerialization.jsonObject(with: data!) as? [String:AnyObject]{
            print(responseJSON)
            print(responseJSON["status"]!)
            print(responseJSON["message"]!)
        
            let response1 = responseJSON["status"]! as! Int
            let response2 = responseJSON["message"]! as! String

            print(response1)
            print(response2)

            //Check response from the sever
            if response1 == 200
            {
                OperationQueue.main.addOperation {

                    //API call Successful and can perform other operatios
                   self.performSegue(withIdentifier: "alreadyHaveAccount", sender: self)
                   print("SignUp Successful")
                }

            }
                
                //API calls when the Email id already exist
            else if response1 == 422{
                OperationQueue.main.addOperation {
                    //print("Email id already exist")
                let alert = UIAlertController(title:"", message: response2, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style:.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
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
    
//    func showAlert(title:String, message:String){
//        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
//        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {(action) in alert.dismiss(animated: true, completion: nil)}))
//        self.present(alert,animated: true,completion: nil)
//    }
    
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
    
    func validateTextFields() -> Bool {
       
                  let email = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
                  let pswd = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
                  let cPswd = confirmTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
                   var flag1 = 1
                 
         if(email!.isEmpty){
            emailErrorLabel.alpha = 1
            flag1 = 0
        }
         else{
            emailErrorLabel.alpha = 0
        }
          if(pswd!.isEmpty){
            pswdErrorLabel.alpha = 1
            flag1 = 0
         }
         else{
            pswdErrorLabel.alpha = 0
        }
          if(cPswd!.isEmpty){
            confirmPswdErrorLabel.alpha = 1
            flag1 = 0
         }
          else{
            confirmPswdErrorLabel.alpha = 0
        }
    
         if(passwordTextField.text != confirmTextField.text){
            confirmPswdErrorLabel.alpha = 1
            flag1 = 0
            
        }
         else{
            confirmPswdErrorLabel.alpha = 0
        }
          if(!isValidEmail(email: emailTextField.text!)) {
            flag1 = 0
            emailErrorLabel.alpha = 1
             
         }
          else {
            emailErrorLabel.alpha = 0
        }
        
        if(!isValidPassword(password: passwordTextField.text!)) {
            flag1 = 0
            pswdErrorLabel.alpha = 1
        }
        else{
            pswdErrorLabel.alpha = 0
        }
        
        
        if (flag1 == 1){
        return true
        }
        else {
            return false
        }
    }
    }

    

//    func SignUpUsingEmailId(){
//        let myUrl = URL(string: "http://35.165.245.142:8080/authentication/signUpByEmail");
//
//             var request = URLRequest(url:myUrl!)
//
//             request.httpMethod = "POST"// Compose a query string
//
//             let postString = "email=gauravk@gmail.com&password=Pass@123&confirmPassword=Pass@123";
//
//             request.httpBody = postString.data(using: String.Encoding.utf8);
//
//
//
//             let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
//
//                 if error != nil
//                 {
//                    print("error=\(String(describing: error))")
//                     return
//                 }
//
//                 // You can print out response object
//                print("response = \(String(describing: response))")
//
//
//
//                do {
//                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
//                    if let parseJSON = json {
//                        let emailID = parseJSON["email"] as? String
//                        print("Email: \(String(describing: emailID))")
//
//                        let password = parseJSON["password"] as? String
//                        print("Password: \(String(describing: password))")
//
//                        let cPassword = parseJSON["confirmPassword"] as? String
//                        print("ConfirmPassword: \(String(describing: cPassword))")
//
//
//                     }
//                 } catch {
//                     print(error)
//                 }
//             }
//             task.resume()
//    }

