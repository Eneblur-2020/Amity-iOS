//
//  ForgotPasswordViewController.swift
//  Amity
//
//  Created by swapna raddi on 15/05/20.
//  Copyright © 2020 Eneblur Consulting. All rights reserved.
//

import UIKit
import Alamofire

class ForgotPasswordViewController: BaseViewController {
    @IBOutlet weak var continueBtn: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailErrorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        continueBtn.layer.cornerRadius = 5
        self.title = "FORGOT PASSWORD"
        let addButtonItem = UIBarButtonItem(title: "<", style: .plain, target: self, action: #selector(onClickBackButton))
            self.navigationItem.leftBarButtonItem  = addButtonItem
        }
    
      @objc func onClickBackButton(){
        self.dismiss(animated: true)
         
          //self.navigationController?.popViewController(animated: true)
      }
      
    @IBAction func onContinueBtnPressed(_ sender: Any){
        if (validateTextFields()){
            self.SignUpUsingEmailId(url: FORGOT_PASSWORD_RECOVER_API)
        }
    }
    func SignUpUsingEmailId(url :String){
        
        let data : [String : String] = [
            "name" : emailTextField.text ?? ""]
        startActivityIndicator()
        if isInternetAvailable(){
            Util.Manager.request(url, method : .post,  parameters: data,encoding: JSONEncoding.default).responseJSON { (response) in
                self.stopActivityIndicator()
                switch response.result{
                case .success(_):
                    if let json = response.result.value{
                        if let jsonData = json as? NSDictionary {
                            let responseMssage = jsonData.object(forKey: "message") as? String ?? ""
                           let status = jsonData.object(forKey: "status") as? Int
                            if status == 200 {
                                if let oTPVarificationViewController = Storyboard.Main.instance.instantiateViewController(withIdentifier: "OTPVarificationViewController") as? OTPVarificationViewController {
                                    oTPVarificationViewController.isFrom = 2
                                    oTPVarificationViewController.modalPresentationStyle = .fullScreen
                                self.navigationController?.pushViewController(oTPVarificationViewController, animated: true)
                                   
                                     
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
    /*func SignUpUsingEmailId(url :String){
        
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "POST"
        
        //let postString = "email=\(String(describing: emailTextField))&password=\(passwordTextField!)&confirmPassword=\(confirmTextField!)"
        var indata: [String: Any] = ["email":"gauuuuravk@gmail.com"]
        indata["email"] =  emailTextField.text
        
        
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
                            self.performSegue(withIdentifier: "OTPSegue", sender: self)
                            isFromOTPSegue = 2
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
 */
    func validateTextFields() -> Bool {
        
        let email = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
       
        var flag1 = 1
        
        if(email!.isEmpty){
            emailErrorLabel.alpha = 1
            flag1 = 0
        }
        else{
            emailErrorLabel.alpha = 0
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
    //Email Validation
    func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: email)
        return result
    }
    
}
