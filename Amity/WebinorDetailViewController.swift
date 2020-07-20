//
//  WebinorDetailViewController.swift
//  Amity
//
//  Created by Vinayak Tudayekar on 10/07/20.
//  Copyright © 2020 Eneblur Consulting. All rights reserved.
//

import UIKit
import Kingfisher
import Alamofire

class WebinorDetailViewController: BaseViewController {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var webinarImage: UIImageView!
    @IBOutlet weak var webinarTitle: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var totalRegistrationCountlabel: UILabel!
    @IBOutlet weak var instructorImage: UIImageView!
    @IBOutlet weak var instructorName: UILabel!
    @IBOutlet weak var instructorDetails: UILabel!
    @IBOutlet weak var webinarDetails:UILabel!
    @IBOutlet weak var instructorContentView:UIView!
    @IBOutlet weak var venueLabel:UILabel!
    var webinarData: Webinor? = nil
    var eventsData: Event? = nil
    var userData = User()
    var isFrom: String?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        initialSetUp()
    }
    
    func initialSetUp(){
        getUserDetail(url: USER_API)
        if isFrom == WEBINAR {
            webinarDetail()
            self.title = "WEBINAR"
        } else {
            self.title = "EVENTS"
            eventsDetail()
            
        }
        
    }
    func getUserDetail(url:String){
        startActivityIndicator()
        if isInternetAvailable(){
            let headers : [String:String] = ["Cookie":"sid=\(Util.getCookie())"]
            Util.Manager.request(url, method : .get, encoding: JSONEncoding.default,headers: headers).responseJSON { (response) in
                self.stopActivityIndicator()
                switch response.result{
                case .success(_):
                    if let json = response.result.value{
                        if let jsonData = json as? NSDictionary {
                            
                            
                            self.userData.email = jsonData.value(forKey: "email") as? String
                            self.userData.userMetaData = jsonData.value(forKey: "userMetaData") as? NSDictionary
                            if let metaData = self.userData.userMetaData  {
                            self.userData.name =  metaData.value(forKey: "name") as? String
                            self.userData.contactNumber = metaData.value(forKey: "contactNumber") as? String
                            print(self.userData.name)
                            print(self.userData.contactNumber)
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
    
    func webinarDetail(){
        
        self.instructorContentView.isHidden = false
        self.venueLabel.isHidden = true
        if let url = URL(string: webinarData?.webinarImage?.value(forKey: "url") as? String ?? "") {
            self.webinarImage.kf.setImage(with: url, placeholder: UIImage(named: ""))
        }
        self.webinarTitle.text = webinarData?.webinarTitle
        self.dateLabel.text = "Date: " + (webinarData?.webinarDate ?? "")
        self.timeLabel.text = "Time: " + (webinarData?.webinarTime ?? "")
        self.totalRegistrationCountlabel.text = "150"
        if let url = URL(string: webinarData?.instructorImage?.value(forKey: "url") as? String ?? "") {
            self.instructorImage.kf.setImage(with: url, placeholder: UIImage(named: "screen4.png"))
        }
        self.instructorName.text = webinarData?.instructorName
        self.instructorDetails.text = webinarData?.instructorDetails
        self.webinarDetails.text = webinarData?.webinarDetails
    }
    func eventsDetail(){
        
        self.instructorContentView.isHidden = true
        self.venueLabel.isHidden = false
        if let url = URL(string: eventsData?.eventImage?.value(forKey: "url") as? String ?? "") {
            self.webinarImage.kf.setImage(with: url, placeholder: UIImage(named: ""))
        }
        
        self.webinarTitle.text = eventsData?.eventTitle
        self.dateLabel.text = "Date: " + (eventsData?.eventDate ?? "")
        self.timeLabel.text = "Time: " + (eventsData?.eventTime ?? "")
        self.totalRegistrationCountlabel.text = "150"
        self.venueLabel.text = "Venue: " + (eventsData?.eventAddress ?? "")
        self.webinarDetails.text = eventsData?.eventDetails
    }
    @IBAction func onClickRegisterButtonClick(_ sender:Any){
         if userData.contactNumber?.isEmpty ?? false || userData.name?.isEmpty ?? false || userData.email?.isEmpty ?? false {
            if let myProfileViewController1 = self.storyboard?.instantiateViewController(withIdentifier: "MyProfileViewController1") as? MyProfileViewController1 {
                self.navigationController?.pushViewController(myProfileViewController1, animated: true)
            }
            
        }else {
            if let registerDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "RegisterDetailViewController") as? RegisterDetailViewController {
                if isFrom == WEBINAR {
                    registerDetailViewController.registerURL = webinarData?.webinarURL } else {
                    
                    registerDetailViewController.registerURL = eventsData?.eventURL
                }
                self.navigationController?.pushViewController(registerDetailViewController, animated: true)
            }
        }
    }
    
    @IBAction func onClickRegisterBottomButtonClick(_ sender:Any){
        if userData.contactNumber?.isEmpty ?? false || userData.name?.isEmpty ?? false || userData.email?.isEmpty ?? false {
            if let myProfileViewController1 = self.storyboard?.instantiateViewController(withIdentifier: "MyProfileViewController1") as? MyProfileViewController1 {
                self.navigationController?.pushViewController(myProfileViewController1, animated: true)
            }
            
        }else {
            if let registerDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "RegisterDetailViewController") as? RegisterDetailViewController {
                if isFrom == WEBINAR {
                    registerDetailViewController.registerURL = webinarData?.webinarURL } else {
                    
                    registerDetailViewController.registerURL = eventsData?.eventURL
                }
                self.navigationController?.pushViewController(registerDetailViewController, animated: true)
            }
        }
    }
    
}
