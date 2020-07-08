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

class ProfileSummaryDetailsViewController: UIViewController {
     weak var delegate: DataEnteredDelegate? = nil
    
    @IBOutlet weak var profileSummaryTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func onBackButtonPressed(_ sender: Any) {
          dismiss(animated: true)
    }
    
    @IBAction func onSaveButtonPressed(_ sender: Any) {
        self.ProfileSummary(url: SUMMARY_API)
        // call this method on whichever class implements our delegate protocol
        delegate?.userDidEnterInformation(info: profileSummaryTextView.text!)

               // go back to the previous view controller
       self.dismiss(animated: true)
    }
    
     func ProfileSummary(url:String){
         
         let data : [String : String] = [
             "profileSummary": profileSummaryTextView.text ?? "",
             ]
         
         if isInternetAvailable(){
             Util.Manager.request(url, method : .post,  parameters: data, encoding: JSONEncoding.default).responseJSON { (response) in
                 switch response.result{
                 case .success(_):
                     if let json = response.result.value{
                         if let jsonData = json as? NSDictionary {
                             if let status = jsonData.object(forKey: "status") as? Int {
                                 
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
