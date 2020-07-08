//
//  ResetPasswordViewController.swift
//  Amity
//
//  Created by Vinayak Tudayekar on 29/06/20.
//  Copyright © 2020 Eneblur Consulting. All rights reserved.
//

import UIKit

class ResetPasswordViewController: UIViewController {
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var newPasswordErrorLabel: UILabel!
    @IBOutlet weak var confirmPasswordErrorLabel: UILabel!
   

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func onContinueBtnPressed(_ sender: Any){
           if (validateTextFields()){
               self.ResetPasswordUsingEmailId(url: RESET_PASSWORD_API )
           }
       }
    func ResetPasswordUsingEmailId(url :String){
        
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "POST"
        
        //let postString = "email=\(String(describing: emailTextField))&password=\(passwordTextField!)&confirmPassword=\(confirmTextField!)"
        var indata: [String: Any] = ["email":"gauuuuravk@gmail.com"]
        indata["email"] =  newPasswordTextField.text
        
        
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
                            self.performSegue(withIdentifier: "signInToTabbar", sender: self)
                            print("sent recover otp Successful")
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
                            print("recover Failed")
                            
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
    
    func validateTextFields() -> Bool {
        
        let email = newPasswordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
       
        var flag1 = 1
        
        if(email!.isEmpty){
            newPasswordErrorLabel.alpha = 1
            flag1 = 0
        }
        else{
            newPasswordErrorLabel.alpha = 0
        }
        
        if (flag1 == 1){
            return true
        }
        else {
            return false
        }
    }

}
