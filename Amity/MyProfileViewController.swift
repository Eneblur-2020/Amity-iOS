//
//  MyProfileViewController.swift
//  Amity
//
//  Created by swapna raddi on 22/05/20.
//  Copyright © 2020 Eneblur Consulting. All rights reserved.
//

import UIKit
import Alamofire
import MobileCoreServices

class MyProfileViewController: UIViewController, DataEnteredDelegate{
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailIdTextField: UITextField!
    @IBOutlet weak var mobileNumberTextfield: UITextField!
    //weak var delegate: DataEnteredDelegate? = nil
    @IBOutlet weak var addProfileSummary: UIButton!
    @IBOutlet weak var addExperience: UIButton!
    @IBOutlet weak var addEducation: UIButton!
    @IBOutlet weak var addResume: UIButton!
    @IBOutlet weak var circularView: UIView!
    @IBOutlet var summaryPopupView: UIView!
    @IBOutlet weak var introTextField: UITextField!
    @IBOutlet weak var buttonSave: UIButton!
    
    //Label
    @IBOutlet weak var profileSummaryLabel: UILabel!
    
    //card View
    @IBOutlet weak var profileSummaryCard: UIView!
    @IBOutlet weak var experienceCardView: UIView!
    @IBOutlet weak var educationCardView: UIView!
    @IBOutlet weak var resumeCardView: UIView!
    
    @IBOutlet weak var comapanyName: UILabel!
    @IBOutlet weak var jobTitle: UILabel!
    @IBOutlet weak var startAndEndDate: UILabel!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addToProfileSummary" {
            let profileSummaryDetailsVC = segue.destination as! ProfileSummaryDetailsViewController
            profileSummaryDetailsVC.delegate = self
        }
    }
    
    func userDidEnterInformation(info: String) {
        profileSummaryLabel.text = info
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetp()
        circularView.layer.masksToBounds = true
        circularView.layer.cornerRadius = circularView.frame.size.width/2
        
        
        //cardView
        profileSummaryCard.layer.cornerRadius = 2
        profileSummaryCard.layer.shadowRadius = 2
        profileSummaryCard.layer.shadowOpacity = 1.0
        profileSummaryCard.layer.shadowColor = UIColor.gray.cgColor
        profileSummaryCard.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        
        experienceCardView.layer.cornerRadius = 2
        experienceCardView.layer.shadowRadius = 2
        experienceCardView.layer.shadowOpacity = 1.0
        experienceCardView.layer.shadowColor = UIColor.gray.cgColor
        experienceCardView.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        
        educationCardView.layer.cornerRadius = 2
        educationCardView.layer.shadowRadius = 2
        educationCardView.layer.shadowOpacity = 1.0
        educationCardView.layer.shadowColor = UIColor.gray.cgColor
        educationCardView.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        
        resumeCardView.layer.cornerRadius = 2
        resumeCardView.layer.shadowRadius = 2
        resumeCardView.layer.shadowOpacity = 1.0
        resumeCardView.layer.shadowColor = UIColor.gray.cgColor
        resumeCardView.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        
        //Popup view
        summaryPopupView.layer.cornerRadius = 5
        summaryPopupView.layer.shadowRadius = 2
        summaryPopupView.layer.shadowOpacity = 1.0
        summaryPopupView.layer.shadowColor = UIColor.gray.cgColor
        summaryPopupView.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        
        addGesture()
        
        //API CALL
        getUserDetails()
    }
    func addGesture() {
        let labelTap = UITapGestureRecognizer(target: self, action: #selector(self.onClickNameTextFieldtap(_:)))
        self.nameTextField.isUserInteractionEnabled = true
        self.nameTextField.addGestureRecognizer(labelTap)
        
        let emailTap = UITapGestureRecognizer(target: self, action: #selector(self.onEmailTextFieldtap))
        self.emailIdTextField.isUserInteractionEnabled = true
        self.emailIdTextField.addGestureRecognizer(emailTap)
        let passwordTap = UITapGestureRecognizer(target: self, action: #selector(self.onMobileNumberTap(_:)))
        self.mobileNumberTextfield.isUserInteractionEnabled = true
        self.mobileNumberTextfield.addGestureRecognizer(passwordTap)
    }
    func initialSetp() {
        // comapanyName.isHidden = true
        comapanyName.text = "Add your past work experience here"
        jobTitle.isHidden = true
        startAndEndDate.isHidden = true
    }
    @objc func onClickNameTextFieldtap(_ sender:Any){
        
        let alert = UIAlertController(title: "My Profile", message: "please enter your name", preferredStyle: .alert)
        alert.addTextField()
        alert.textFields?[0].placeholder = "name"
        alert.textFields?[0].keyboardType = UIKeyboardType.alphabet
        alert.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: { (action) in
            print("cancel")
        }))
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { (action) in
            let emailtext = alert.textFields?[0].text
            
            self.nameTextField.text = emailtext
            self.updateNameApiCal()
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    @objc func onEmailTextFieldtap(_ sender:Any){
        
        let alert = UIAlertController(title: "My Profile", message: "Please enter your email id", preferredStyle: .alert)
        alert.addTextField()
        alert.textFields?[0].placeholder = "emailID"
        alert.textFields?[0].keyboardType = UIKeyboardType.emailAddress
        alert.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: { (action) in
            print("cancel")
        }))
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { (action) in
            let emailtext = alert.textFields?[0].text
            
            self.emailIdTextField.text = emailtext
            self.updateEmailApiCal()
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    @objc func onMobileNumberTap(_ sender:Any){
        
        let alert = UIAlertController(title: "My Profile", message: "Please enter your password", preferredStyle: .alert)
        alert.addTextField()
        alert.textFields?[0].placeholder = "password"
        alert.textFields?[0].keyboardType = UIKeyboardType.alphabet
        alert.textFields?[0].isSecureTextEntry = true
        alert.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: { (action) in
            print("cancel")
        }))
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { (action) in
            let emailtext = alert.textFields?[0].text
            self.updatePhoneApiCal()
            self.mobileNumberTextfield.text = emailtext
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    func updateNameApiCal(){
        
        let data : [String : String] = [
            "name" : nameTextField.text ?? ""]
        if isInternetAvailable(){
            Util.Manager.request(UPDATE_NAME_API, method : .put,  parameters: data, encoding: JSONEncoding.default).responseJSON { (response) in
                switch response.result{
                case .success(_):
                    if let json = response.result.value{
                        if let jsonData = json as? NSDictionary {
                            if let status = jsonData.object(forKey: "status") as? Int {
                                //TODO : LOCALIZATION REQUIRED
                                
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
    func updateEmailApiCal(){
        
        let data : [String : String] = [
            "email" : emailIdTextField.text ?? ""]
        if isInternetAvailable(){
            Util.Manager.request(UPDATE_EMAIL_API, method : .put,  parameters: data, encoding: JSONEncoding.default).responseJSON { (response) in
                switch response.result{
                case .success(_):
                    if let json = response.result.value{
                        if let jsonData = json as? NSDictionary {
                            if let status = jsonData.object(forKey: "status") as? Int {
                                //TODO : LOCALIZATION REQUIRED
                                
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
    func updatePhoneApiCal(){
        
        let data : [String : String] = [
            "countryCode": "+91",
            "contactNumber": mobileNumberTextfield.text ?? ""]
        
        if isInternetAvailable(){
            Util.Manager.request(UPDATE_MOBILE_API, method : .put,  parameters: data, encoding: JSONEncoding.default).responseJSON { (response) in
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
    
    func getUserDetails(){
        
        let userUrl = "http://35.165.245.142:8080/authentication/user"
        // Add one parameter
        let myUrl = NSURL(string: userUrl)
        
        // Creaste URL Request
        let request = NSMutableURLRequest(url:myUrl! as URL)
        request.httpMethod = "GET"
        request.setValue(UserDefaults.standard.string(forKey: "USER"), forHTTPHeaderField: "Cookie")
        
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
                    
                }
            }
            catch {
                print("Error -> \(error)")
            }
            
        }
        
        
        task.resume()
    }
    
    @IBAction func onBackButtonPressed(_ sender: Any) {
        dismiss(animated: true)
    }
    
    //    @IBAction func onPopupSaveBtnPressed(_ sender: Any) {
    //        self.performSegue(withIdentifier: "profileSummaryDetails", sender: self)
    //    }
    //
    //    @IBAction func onAddButtonPressed(_ sender: Any) {
    //         self.view.addSubview(summaryPopupView)
    //         summaryPopupView.center = self.view.center
    //    }
    
    @IBAction func onAddSummaryBtnClick(_ sender: Any) {
        self.performSegue(withIdentifier: "addToProfileSummary", sender: self)
        
    }
    @IBAction func onAddEducationBtnClick(_ sender: Any) {
        self.performSegue(withIdentifier: "myProfileToEducation", sender: self)
    }
    @IBAction func onAddExperienceBtnClick(_ sender: Any) {
        self.performSegue(withIdentifier: "experienceSegue", sender: self)
    }
    @IBAction func onAddResumeBtnClick(_ sender: Any) {
        openDocumentPicker()
        
    }
}
extension MyProfileViewController: UIDocumentPickerDelegate,UINavigationControllerDelegate
{
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        let myURL = url as URL
        print("import result : \(myURL)")
    }
    
    
    func documentMenu(_ documentMenu:UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
        documentPicker.delegate = self
        present(documentPicker, animated: true, completion: nil)
    }
    
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print("view was cancelled")
        dismiss(animated: true, completion: nil)
    }
    func openDocumentPicker(){
        let docMenu = UIDocumentPickerViewController(documentTypes: [String(kUTTypePDF),String(kUTTypeText)], in: .import)
        docMenu.delegate = self  as UIDocumentPickerDelegate
        docMenu.modalPresentationStyle = .formSheet
        self.present(docMenu, animated: true, completion: nil)
    }
    
}


