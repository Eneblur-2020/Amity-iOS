//
//  InterestedformTableViewController.swift
//  Amity
//
//  Created by Snehalatha Desai on 17/07/20.
//  Copyright © 2020 Eneblur Consulting. All rights reserved.
//

import UIKit
import Alamofire
class InterestedformTableViewController: UITableViewController {

      @IBOutlet weak var nametxt: UITextField!
     @IBOutlet weak var emailtxt: UITextField!
     @IBOutlet weak var phonetxt: UITextField!
     @IBOutlet weak var countrytxt: UITextField!
     @IBOutlet weak var citytxt: UITextField!
     @IBOutlet weak var exptxt: UITextField!
     @IBOutlet weak var orgtxt: UITextField!
     @IBOutlet weak var qualtxt: UITextField!
    
    @IBOutlet weak var phoneNumberErrorLabel: UILabel!
    @IBOutlet weak var emailErrorLabel: UILabel!
    
    
    @IBAction func submit_action(_sender : UIButton)
    {
        email=emailtxt.text!
        name=nametxt.text!
        phone=phonetxt.text!
        city=citytxt.text!
        org=orgtxt.text!
        qual=qualtxt.text!
        country=countrytxt.text!
         exp=exptxt.text!
        
       if city.isEmpty || org.isEmpty || qual.isEmpty || country.isEmpty || exp.isEmpty
        {
           
         displayErrorMessage(message: "Please enter all the fields!")
        }
        else
        {
            if (validateEmailTextFields())
            {
                if (validatePhoneTextFields())
                {
               
                submitform(url: SUBMIT_STUDENTAPPLICATION_API)
                }
                else{
                    displayErrorMessage(message: "Please enter valid phone number")
                }
                 
            }
            else
            {
                 displayErrorMessage(message: "Please enter valid email address")
            }
           
           
        }
        
        
    }
    
    
    
    
    
    func submitform(url :String){
        
        
       
        
        //let postString = "email=\(String(describing: emailTextField))&password=\(passwordTextField!)&confirmPassword=\(confirmTextField!)"
        email=emailtxt.text!
               name=nametxt.text!
               phone=phonetxt.text!
               city=citytxt.text!
               org=orgtxt.text!
               qual=qualtxt.text!
               country=countrytxt.text!
                exp=exptxt.text!
        let indata: [String: Any] = ["courseId":courseid,"name":name,"email":email,"country":country,"contactNumber":phone,"city":city,"experience":exp,"organization": org,"education":qual]
        /*
         {
           "courseId": "string",
           "name": "string",
           "email": "string",
           "country": "string",
           "contactNumber": "string",
           "city": "string",
           "experience": "string",
           "organization": "string",
           "education": "string"
         }
         */
        
        
        // let content : String
        //let jrequest = try? JSONSerialization.data(withJSONObject: indata,options: [])
          if isInternetAvailable(){
                             Util.Manager.request(url, method : .put, parameters: indata,encoding: JSONEncoding.default).responseJSON { (response) in
                                   switch response.result{
                                   case .success(_):
                                       if let json = response.result.value{
                                           if let jsonData = json as? NSDictionary {
                                               if let status = jsonData.object(forKey: "status") as? Int {
                                                   
                                                 if status == 200
                                                 {
              //
                                                    self.showsuccessaler(message: "Your Enrollment for the course is submitted! Thank you")
                                                 
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
                               //Util.showWhistle(message: NO_INTERNET, viewController: CourseViewController.self)
        }
    }
    func displayErrorMessage(message:String) {
         let alertView = UIAlertController(title: "Error!", message: message, preferredStyle: .alert)
         let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
         }
         alertView.addAction(OKAction)
         if let presenter = alertView.popoverPresentationController {
             presenter.sourceView = self.view
             presenter.sourceRect = self.view.bounds
         }
         self.present(alertView, animated: true, completion:nil)
     }
    func showsuccessaler (message:String)
         {
             let showAlert = UIAlertController(title: "", message: message, preferredStyle: .alert)
    
             showAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                 // your actions here...
             // self.dismiss(animated: true, completion: nil)
                if(self.fees == "0")
                {
                    guard let url = URL(string: self.coursesurl) else {
                      return //be safe
                    }

                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    } else {
                        UIApplication.shared.openURL(url)
                    }
                }
              
             }))
             self.present(showAlert, animated: true, completion: nil)
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
        
        let email = emailtxt.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        //let pswd = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        var flag1 = 1
        
        if(email!.isEmpty){
            emailErrorLabel.alpha = 1
            flag1 = 0
        }
        else{
            emailErrorLabel.alpha = 0
        }
        
        
        if(!isValidEmail(email: emailtxt.text!)) {
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
        
        let phone = phonetxt.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if(phone!.isEmpty){
            phoneNumberErrorLabel.alpha = 1
        }
        else if(!validatePhoneNum(value: phonetxt.text!)) {
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
    
    var courseid = String()
     var coursesurl = String()
    var fees = String()
      var name = String()
      var email = String()
      var phone = String()
      var country = String()
      var city = String()
      var exp = String()
      var qual = String()
      var org = String()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 10
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
