//
//  ProfileSummaryViewController.swift
//  Amity
//
//  Created by swapna raddi on 22/05/20.
//  Copyright © 2020 Eneblur Consulting. All rights reserved.
//

import UIKit

class ProfileSummaryViewController: UIViewController {
    @IBOutlet weak var profileSummaryTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func onSaveButtonClicked(_ sender: Any) {
       self.ProfileSummary(url:PROFILE_SUMMARY_API )
    }
    
    @IBAction func onBackButtonPressed(_ sender: Any) {
        dismiss(animated: true)
    }
    
    //API call for Profile Summary
    func ProfileSummary(url :String){
              
          let request = NSMutableURLRequest(url: NSURL(string: url)! as URL)
          request.httpMethod = "POST"
           
           var indata: [String: Any] = ["profileSummary":"1234567"]
              indata["profileSummary"] = profileSummaryTextView.text
           
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
                        print("Profile Summary Upadated")
                           }

                       }
                    else {
                        OperationQueue.main.addOperation {
                        print("Failed")

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
}
    
