//
//  ExperiencePageViewController.swift
//  Amity
//
//  Created by swapna raddi on 26/05/20.
//  Copyright © 2020 Eneblur Consulting. All rights reserved.
//

import UIKit
import Alamofire

class ExperiencePageViewController: BaseViewController {
    @IBOutlet var datePickerPopup: UIView!
    @IBOutlet weak var experienceCardView: UIView!
    @IBOutlet weak var jobTitleTextField: UITextField!
    @IBOutlet weak var companyNameTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var startDate: UITextField!
    @IBOutlet weak var endDate: UITextField!
    @IBOutlet weak var startDateButton: UIButton!
    @IBOutlet weak var endDateButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    let datePicker = UIDatePicker()
    var expDetail : MyExperince?
    var isDeleteData : Bool?
    var isEditData: Bool?
    //let picker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //popupView
        datePickerPopup.layer.cornerRadius = 5
        datePickerPopup.layer.shadowRadius = 2
        datePickerPopup.layer.shadowOpacity = 1.0
        datePickerPopup.layer.shadowColor = UIColor.gray.cgColor
        datePickerPopup.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        
        experienceCardView.layer.cornerRadius = 2
        experienceCardView.layer.shadowRadius = 2
        experienceCardView.layer.shadowOpacity = 1.0
        experienceCardView.layer.shadowColor = UIColor.gray.cgColor
        experienceCardView.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        
        createStartDatePicker()
        createEndDatePicker()
        initialSetUp()
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    func initialSetUp(){
        
        jobTitleTextField.text = expDetail?.jobTitle
        companyNameTextField.text = expDetail?.company
        cityTextField.text = expDetail?.city
        startDate.text = Helper.dateFormatter_dd_MM_yyyy(dateString:expDetail?.startDate ?? "")
        if expDetail?.endDate == "Present"{
            endDate.text = "Present"
        } else {
            endDate.text = Helper.dateFormatter_dd_MM_yyyy(dateString: expDetail?.endDate ?? "")
        }
        
        deleteButton.isHidden = isDeleteData ?? true
        
        jobTitleTextField.delegate = self
        companyNameTextField.delegate = self
        cityTextField.delegate = self
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
        formatter.dateStyle = .short
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
        //formatter.dateStyle = .short
        formatter.dateFormat = "dd-MM-yyyy"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale.current
        let dateString = formatter.string(from: datePicker.date)
        
        endDate.text = "\(dateString)"
        self.view.endEditing(true)
        
    }
    
    @IBAction func onClickSwitch(_ sender: UISwitch) {
        //        if sender.isOn {
        //           endDate.text = "Present"
        //        } else {
        //            endDate.text = ""
        //        }
        endDate.text = sender.isOn ? "Present" : ""
    }
    
    
    @IBAction func onBackButtonPressed(_ sender: Any) {
        dismiss(animated: true)
        
    }
    
    @IBAction func onSaveButtonClick(_ sender: Any) {
        //self.performSegue(withIdentifier: "SaveExpToExpCard", sender: self)
        if isEditData ?? false {
            UpdateExperienceDetail()
        } else {
        saveExperienceDetail()
        }
    }
    
    @IBAction func onStartButtonClick(_ sender: Any) {
        //        self.view.addSubview(datePickerPopup)
        //        datePickerPopup.center = self.view.center
    }
    
    @IBAction func onEndButtonClick(_ sender: Any) {
        //        self.view.addSubview(datePickerPopup)
        //        datePickerPopup.center = self.view.center
    }
    @IBAction func onDeleteButtonClick(_ sender:Any){
        deleteExperienceData()
    }
    
    //    @IBAction func onClickSaveButton(_ sender: Any) {
    //
    //
    //     // self.performSegue(withIdentifier: "SaveExpToExpCard", sender: self)
    //       // self.prepareForSegue(segue: UIStoryboard, sender: AnyObject)
    //    }
    func UpdateExperienceDetail(){
        
        let data :[String:String] = [
            "jobTitle": jobTitleTextField.text ?? "",
            "city": cityTextField.text ?? "",
            "company": companyNameTextField.text ?? "",
            "fromDate": startDate.text ?? "",
            "toDate": endDate.text ?? ""
        ]
        if isInternetAvailable(){
            startActivityIndicator()
            
            Util.Manager.request(UPDATE_EXPERIENCE_API+(expDetail?.id ?? ""), method : .put,parameters: data, encoding: JSONEncoding.default).responseJSON { (response) in
                self.stopActivityIndicator()
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
        } else {
            Util.showWhistle(message: NO_INTERNET, viewController: self)
        }
        
    }
    func saveExperienceDetail(){
        
        let data :[String:String] = [
            "jobTitle": jobTitleTextField.text ?? "",
            "city": cityTextField.text ?? "",
            "company": companyNameTextField.text ?? "",
            "fromDate": startDate.text ?? "",
            "toDate": endDate.text ?? ""
        ]
        if isInternetAvailable(){
            startActivityIndicator()
            Util.Manager.request(EXPERIENCE_API, method : .post,parameters: data, encoding: JSONEncoding.default).responseJSON { (response) in
                self.stopActivityIndicator()
                switch response.result{
                case .success(_):
                    if let json = response.result.value{
                        if let jsonData = json as? NSDictionary {
                            let responseMessage = jsonData.object(forKey: "message") as? String
                            if let status = jsonData.object(forKey: "status") as? Int {
                                if status == 200 {
                                        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                        let expCardViewController = storyBoard.instantiateViewController(withIdentifier: "ExpCardViewController") as! ExpCardViewController
                                        let myExperience = MyExperince()
                                        myExperience.company = self.companyNameTextField.text
                                        myExperience.jobTitle = self.jobTitleTextField.text
                                        myExperience.city = self.cityTextField.text
                                        myExperience.startDate = self.startDate.text
                                        myExperience.endDate = self.endDate.text
                                        expCardViewController.expCardData = [myExperience]
                                        self.navigationController?.pushViewController(expCardViewController, animated: true)
                                    
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
    func deleteExperienceData()
    {
        if isInternetAvailable(){
            if let expID = expDetail?.id {
                Util.Manager.request(DELETE_EXPERIENCE_API + expID, method : .delete, encoding: JSONEncoding.default).responseJSON { (response) in
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

extension ExperiencePageViewController: ExperienceDelegate {
    func experienceInformation(experienceCardData: MyExperince) {
        companyNameTextField.text = experienceCardData.company
        jobTitleTextField.text = experienceCardData.jobTitle
        cityTextField.text = experienceCardData.city
        startDate.text = experienceCardData.startDate
        endDate.text = experienceCardData.endDate
    }
    
}
extension ExperiencePageViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ scoreText: UITextField) -> Bool {
        return self.view.endEditing(true)
        
    }
}
