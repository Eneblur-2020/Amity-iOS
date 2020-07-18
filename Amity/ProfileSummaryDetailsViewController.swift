//
//  ProfileSummaryDetailsViewController.swift
//  Amity
//
//  Created by swapna raddi on 31/05/20.
//  Copyright © 2020 Eneblur Consulting. All rights reserved.
//

import UIKit
import Alamofire

// protocol used for sending data back
protocol DataEnteredDelegate: class {
    func userDidEnterInformation(info: String)
}

class ProfileSummaryDetailsViewController: BaseViewController {
     weak var delegate: DataEnteredDelegate? = nil
    
    @IBOutlet weak var profileSummaryTextView: UITextView!
    var profileSummary = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetUp()
    }
    func initialSetUp(){
        self.title = "PROFILE SUMMARY"
               let button1 = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(onSaveButtonPressed))
               self.navigationItem.rightBarButtonItem  = button1;        profileSummaryTextView.text = profileSummary
        profileSummaryTextView.delegate = self
    }

    @IBAction func onBackButtonPressed(_ sender: Any) {
          //dismiss(animated: true)
    }
    
    @objc func onSaveButtonPressed(_ sender: Any) {
        self.ProfileSummary(url: SUMMARY_API)
        // call this method on whichever class implements our delegate protocol
        delegate?.userDidEnterInformation(info: profileSummaryTextView.text!)
        
               // go back to the previous view controller
    }
    
     func ProfileSummary(url:String){
         
         let data : [String : String] = [
             "profileSummary": profileSummaryTextView.text ?? "",
             ]
         startActivityIndicator()
         if isInternetAvailable(){
             Util.Manager.request(url, method : .post,  parameters: data, encoding: JSONEncoding.default).responseJSON { (response) in
                self.stopActivityIndicator()
                 switch response.result{
                 case .success(_):
                     if let json = response.result.value{
                         if let jsonData = json as? NSDictionary {
                              let responseMessage = jsonData.object(forKey: "message") as? String
                              let status = jsonData.object(forKey: "status") as? Int
                            if status == 200 {
                                 self.navigationController?.popViewController(animated: true)
                            }else if status == 422{
                                OperationQueue.main.addOperation {
                                    let alert = UIAlertController(title:"", message: responseMessage, preferredStyle: UIAlertController.Style.alert)
                                    alert.addAction(UIAlertAction(title: "OK", style:.default, handler: nil))
                                    self.present(alert, animated: true, completion: nil)
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
extension ProfileSummaryDetailsViewController: UITextViewDelegate {
   func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}
