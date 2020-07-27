//
//  EducationViewController.swift
//  Amity
//
//  Created by Vinayak Tudayekar on 02/07/20.
//  Copyright © 2020 Eneblur Consulting. All rights reserved.
//

import UIKit
import Alamofire

class EducationViewController: BaseViewController {
    
    @IBOutlet var datePickerPopup: UIView!
    @IBOutlet weak var educationCardView: UIView!
    @IBOutlet weak var school_College: UITextField!
    @IBOutlet weak var degree: UITextField!
    @IBOutlet weak var startDate: UITextField!
    @IBOutlet weak var endDate: UITextField!
    @IBOutlet weak var startDateButton: UIButton!
    @IBOutlet weak var endDateButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    let datePicker = UIDatePicker()
    var educationDetail : MyEducation?
    var isDeleteData : Bool?
    var isEditData: Bool?
    override func viewDidLoad() {
        super.viewDidLoad()
        datePickerSetup()
        initialSetUp()
        educationCardViewSetup()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    func initialSetUp(){
        degree.text = educationDetail?.Degree
        school_College.text = educationDetail?.College_School
        startDate.text = Helper.dateFormatter_dd_MM_yyyy(dateString:educationDetail?.startDate ?? "")
        endDate.text = Helper.dateFormatter_dd_MM_yyyy(dateString: educationDetail?.endDate ?? "")
        
        deleteButton.isHidden = isDeleteData ?? true
        degree.delegate = self
        school_College.delegate = self
        
    }
    @IBAction func onBackButtonClick(_ sender: Any) {
        // dismiss(animated: true)
        self.navigationController?.popViewController(animated: true)
    }
    func datePickerSetup(){
        datePickerPopup.layer.cornerRadius = 5
        datePickerPopup.layer.shadowRadius = 2
        datePickerPopup.layer.shadowOpacity = 1.0
        datePickerPopup.layer.shadowColor = UIColor.gray.cgColor
        datePickerPopup.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        createStartDatePicker()
        createEndDatePicker()
    }
    func educationCardViewSetup(){
        educationCardView.layer.cornerRadius = 2
        educationCardView.layer.shadowRadius = 2
        educationCardView.layer.shadowOpacity = 1.0
        educationCardView.layer.shadowColor = UIColor.gray.cgColor
        educationCardView.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
    }
    
    func createStartDatePicker(){
        //toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //done button for toolbar
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([done], animated: false)
        
        startDate.inputAccessoryView = toolbar
        startDate.inputView = datePicker
        
        // format picker for date
        datePicker.datePickerMode = .date
        
    }
    @objc func donePressed(){
        //format date
        let formatter = DateFormatter()
        //  formatter.dateStyle = .short
        formatter.dateFormat = "dd-MM-yyyy"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale.current
        let dateString = formatter.string(from: datePicker.date)
        
        startDate.text = "\(dateString)"
        self.view.endEditing(true)
        
    }
    func createEndDatePicker() {
        //toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //done button for toolbar
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(onDonePressed))
        toolbar.setItems([done], animated: false)
        endDate.inputAccessoryView = toolbar
        endDate.inputView = datePicker
        
        // format picker for date
        datePicker.datePickerMode = .date
    }
    
    @objc func onDonePressed(){
        //format date
        let formatter = DateFormatter()
        // formatter.dateStyle = .short
        formatter.dateFormat = "dd-MM-yyyy"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale.current
        let dateString = formatter.string(from: datePicker.date)
        
        endDate.text = "\(dateString)"
        self.view.endEditing(true)
        
    }
    @IBAction func onSaveButtonClick(_ sender: Any) {
        if isEditData ?? false{
            UpdateEducation()
        }else {
            addEducation()
        }
        
    }
    @IBAction func onDeleteButtonClick(_ sender:Any){
        deleteEducationData()
    }
    func UpdateEducation(){
        
        let data : [String : String] = [
            "degreeTitle": degree.text ?? "",
            "instituteName": school_College.text ?? "",
            "fromDate": startDate.text ?? "",
            "toDate": endDate.text ?? ""]
        startActivityIndicator()
        if isInternetAvailable(){
            Util.Manager.request(UPDATE_EDUCATION_API+(educationDetail?.id ?? ""), method : .put,  parameters: data, encoding: JSONEncoding.default).responseJSON { (response) in
                self.stopActivityIndicator()
                switch response.result{
                case .success(_):
                    if let json = response.result.value{
                        if let jsonData = json as? NSDictionary {
                            let responseMessage = jsonData.object(forKey: "message") as? String
                            if let status = jsonData.object(forKey: "status") as? Int {
                                if status == 200{
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
    func addEducation(){
        
        let data : [String : String] = [
            "degreeTitle": degree.text ?? "",
            "instituteName": school_College.text ?? "",
            "fromDate": startDate.text ?? "",
            "toDate": endDate.text ?? ""]
        startActivityIndicator()
        if isInternetAvailable(){
            Util.Manager.request(EDUCATION_API, method : .post,  parameters: data, encoding: JSONEncoding.default).responseJSON { (response) in
                self.stopActivityIndicator()
                switch response.result{
                case .success(_):
                    if let json = response.result.value{
                        if let jsonData = json as? NSDictionary {
                            let responseMessage = jsonData.object(forKey: "message") as? String
                            if let status = jsonData.object(forKey: "status") as? Int {
                                if status == 200 {
                                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                    let educationCardViewController = storyBoard.instantiateViewController(withIdentifier: "EducationCardViewController") as! EducationCardViewController
                                    let myEducation = MyEducation()
                                    myEducation.Degree = self.degree.text
                                    myEducation.College_School = self.school_College.text
                                    myEducation.startDate = self.startDate.text
                                    myEducation.endDate = self.endDate.text
                                    educationCardViewController.educationCardData = [myEducation]
                                    //educationCardViewController.educationDelegate = self
                                    educationCardViewController.educationCardData = [myEducation]
                                    self.navigationController?.pushViewController(educationCardViewController, animated: true)
                                }else if status == 422{
                                    OperationQueue.main.addOperation {
                                        let alert = UIAlertController(title:"", message: responseMessage, preferredStyle: UIAlertController.Style.alert)
                                        alert.addAction(UIAlertAction(title: "OK", style:.default, handler: nil))
                                        self.present(alert, animated: true, completion: nil)
                                    }
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
    func deleteEducationData()
    {
        if isInternetAvailable(){
            if let educationID = educationDetail?.id {
                Util.Manager.request(DELETE_EDUCATION_API + educationID, method : .delete, encoding: JSONEncoding.default).responseJSON { (response) in
                    switch response.result{
                    case .success(_):
                        if let json = response.result.value{
                            if let jsonData = json as? NSDictionary {
                                let responseMessage = jsonData.object(forKey: "message") as? String
                                if let status = jsonData.object(forKey: "status") as? Int {
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
                        }
                        break
                    case .failure(_):
                        if let statusCode = response.response?.statusCode {
                            
                        }
                        break
                        
                    }
                }
            }
        } else {
            Util.showWhistle(message: NO_INTERNET, viewController: self)
        }
        
    }
    
    
    
}
extension EducationViewController: EducationDelegate {
    func educationInformation(educationCardData: MyEducation) {
        degree.text = educationCardData.Degree
        school_College.text = educationCardData.College_School
        startDate.text = educationCardData.startDate
        endDate.text = educationCardData.endDate
    }
    
    
    
}
extension EducationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ scoreText: UITextField) -> Bool {
        return self.view.endEditing(true)
        
    }
}
