//
//  MyProfileViewController1.swift
//  Amity
//
//  Created by Vinayak Tudayekar on 04/07/20.
//  Copyright © 2020 Eneblur Consulting. All rights reserved.
//

import UIKit
import Alamofire
import MobileCoreServices
class MyProfileViewController1: UIViewController {
    
    @IBOutlet weak var myProfileTableView: UITableView!
    var myProfileTitleArray = ["","PROFILE SUMMARY","EXPERIENCE","EDUCATION","RESUME"]
    // var myProfileTitleArray = ["PROFILE SUMMARY"]
    var myExperienceArray = ["EXPERIENCE"]
    var myEducationArray = ["EDUCATION1","EDUCATION2","EDUCATION3"]
    var myResumeArray = ["RESUME"]
    var mySummaryDetails = ["Add a little about yourself                                                         (Upto 400 characters)"]
    var myExpDetail = ["Add your past experience here1","Add your past experience here2"]
    var myEducationDetail = ["Add your educational qualification1","Add your educational qualification2","Add your educational qualification3"]
    var myResumeDetails = ["Attach your resume here"]
    //  var myProfileDescriptionArray = ["Add a little about yourself                                                         (Upto 400 characters)","Add your past experience here","Add your educational qualification","Attach your resume here"]
    var sectionArray = ["1","2","3","4","5"]
    var expCardData = [MyExperince]()
    var educationCardData = [MyEducation]()
    var userData = User()
    override func viewDidLoad() {
        super.viewDidLoad()
        intialSetup()
        //  print(myProfileTitleArray.count)
        //print(myProfileDescriptionArray.count)
        // Do any additional setup after loading the view.
    }
    func intialSetup(){
        registerTableViewCell()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        getAllProfileDetails()
    }
    func getAllProfileDetails(){
        getUserDetail(url: USER_API)
        getExpDetails(url: EXPERIENCE_API)
        getEductaionDetails(url: EDUCATION_API)
        
    }
    func registerTableViewCell(){
        
        self.myProfileTableView.register(UINib(nibName: "MyProfileTableViewCell", bundle: nil), forCellReuseIdentifier: "MyProfileTableViewCell")
        self.myProfileTableView.register(UINib(nibName: "MyProfileDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "MyProfileDetailTableViewCell")
        self.myProfileTableView.register(UINib(nibName: "MyExperienceTableViewCell", bundle: nil), forCellReuseIdentifier: "MyExperienceTableViewCell")
        self.myProfileTableView.register(UINib(nibName: "MyEducationTableViewCell", bundle: nil), forCellReuseIdentifier: "MyEducationTableViewCell")
        self.myProfileTableView.register(UINib(nibName: "MyResumeTableViewCell", bundle: nil), forCellReuseIdentifier: "MyResumeTableViewCell")
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
            let userNameText = alert.textFields?[0].text
            
            let indexPath = IndexPath(row: 0, section: 0)
            let cell = self.myProfileTableView.cellForRow(at: indexPath) as! MyProfileTableViewCell
            cell.userNameTextField.text = userNameText
            self.updateNameApiCal(userName: cell.userNameTextField.text ?? "")
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
            let indexPath = IndexPath(row: 0, section: 0)
            let cell = self.myProfileTableView.cellForRow(at: indexPath) as! MyProfileTableViewCell
            cell.userEmailIdTextField.text = emailtext
            self.updateEmailApiCal(emailId:cell.userEmailIdTextField.text ?? "")
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    @objc func onMobileNumberTap(_ sender:Any){
        
        let alert = UIAlertController(title: "My Profile", message: "Please enter your mobile number", preferredStyle: .alert)
        alert.addTextField()
        alert.textFields?[0].placeholder = "Phone number"
        alert.textFields?[0].keyboardType = UIKeyboardType.alphabet
        // alert.textFields?[0].isSecureTextEntry = true
        alert.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: { (action) in
            print("cancel")
        }))
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { (action) in
            let phoneNumberText = alert.textFields?[0].text
            
            let indexPath = IndexPath(row: 0, section: 0)
            let cell = self.myProfileTableView.cellForRow(at: indexPath) as! MyProfileTableViewCell
            cell.phoneNumberTextField.text = phoneNumberText
            self.updatePhoneApiCal(phoneNumber:  cell.phoneNumberTextField.text ?? "")
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    func updateNameApiCal(userName:String){
        
        let data : [String : String] = [
            "name" : userName]
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
    func updateEmailApiCal(emailId:String){
        
        let data : [String : String] = [
            "email" : emailId ]
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
    func updatePhoneApiCal(phoneNumber:String){
        
        let data : [String : String] = [
            "countryCode": "+91",
            "contactNumber": phoneNumber ?? ""]
        
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
    
    func getExpDetails(url:String){
        
        if isInternetAvailable(){
            Util.Manager.request(url, method : .get, encoding: JSONEncoding.default).responseJSON { (response) in
                switch response.result{
                case .success(_):
                    if let json = response.result.value{
                        if let jsonData = json as? NSDictionary {
                            let status = jsonData.object(forKey: "status") as? Int
                            print(jsonData)
                            self.expCardData.removeAll()
                            if status == 200 {
                                if let data = jsonData.object(forKey: "data") as? NSArray{
                                    for exp in data {
                                        let myExp = MyExperince()
                                        let i = exp as! NSDictionary
                                        myExp.jobTitle = i.value(forKey: "jobTitle") as? String
                                        myExp.company = i.value(forKey: "company") as? String
                                        myExp.city = i.value(forKey: "city") as? String
                                        
                                        myExp.startDate = Helper.dateFormatterMMMyyyy(dateString:i.value(forKey: "fromDate") as? String ?? "")
                                        
                                        myExp.endDate = Helper.dateFormatterMMMyyyy(dateString:i.value(forKey: "toDate") as? String ?? "")
                                        myExp.id = i.value(forKey: "_id") as? String
                                        self.expCardData.append(myExp)
                                        
                                    }
                                    self.myProfileTableView.reloadData()
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
    func getEductaionDetails(url:String){
        
        if isInternetAvailable(){
            Util.Manager.request(url, method : .get, encoding: JSONEncoding.default).responseJSON { (response) in
                switch response.result{
                case .success(_):
                    if let json = response.result.value{
                        if let jsonData = json as? NSDictionary {
                            let status = jsonData.object(forKey: "status") as? Int
                            print(jsonData)
                            self.educationCardData.removeAll()
                            if status == 200 {
                                if let data = jsonData.object(forKey: "data") as? NSArray{
                                    for education in data {
                                        let myEducation = MyEducation()
                                        let i = education as! NSDictionary
                                        myEducation.Degree = i.value(forKey: "degreeTitle") as? String
                                        myEducation.College_School = i.value(forKey: "instituteName") as? String
                                        
                                        
                                        myEducation.startDate = Helper.dateFormatterMMMyyyy(dateString:i.value(forKey: "fromDate") as? String ?? "")
                                        
                                        
                                        myEducation.endDate = Helper.dateFormatterMMMyyyy(dateString:i.value(forKey: "toDate") as? String ?? "")
                                        myEducation.id = i.value(forKey: "_id") as? String
                                        self.educationCardData.append(myEducation)
                                        
                                    }
                                    self.myProfileTableView.reloadData()
                                }
                                
                            }
                        }
                    }
                    break
                case .failure(_):
                    if (response.response?.statusCode) != nil {
                        
                    }
                    break
                    
                }
            }
        } else {
            Util.showWhistle(message: NO_INTERNET, viewController: self)
        }
        
    }
    func getUserDetail(url:String){
        
        if isInternetAvailable(){
            Util.Manager.request(url, method : .get, encoding: JSONEncoding.default).responseJSON { (response) in
                switch response.result{
                case .success(_):
                    if let json = response.result.value{
                        if let jsonData = json as? NSDictionary {
                            
                            print(jsonData)
                            
                            
                            
                            self.userData.email = jsonData.value(forKey: "email") as? String
                            
                            self.userData.userMetaData = jsonData.value(forKey: "userMetaData") as? NSDictionary
                            
                            
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
    @objc func onClickProfileSummaryAddButton(){
        self.performSegue(withIdentifier: "myProfileToSummary", sender: self)
    }
    
    @objc func onClickExperienceAddButton(sender:UIButton){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let experiencePageViewController = self.storyboard?.instantiateViewController(withIdentifier: "ExperiencePageViewController") as! ExperiencePageViewController
        let indexpath = IndexPath(row: sender.tag, section: 2)
        experiencePageViewController.expDetail = expCardData[indexpath.row]
        experiencePageViewController.isDeleteData = false
        
        self.navigationController?.pushViewController(experiencePageViewController, animated: false)
        
    }
    @objc func onClickEducationAddButton(sender:UIButton){
        // self.performSegue(withIdentifier: "myProfileToEducation", sender: self)
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let educationViewController = self.storyboard?.instantiateViewController(withIdentifier: "EducationViewController") as! EducationViewController
        let indexpath = IndexPath(row: sender.tag, section: 2)
        educationViewController.educationDetail = educationCardData[indexpath.row]
        educationViewController.isDeleteData = false
        self.navigationController?.pushViewController(educationViewController, animated: true)
    }
    @objc func onClickResumeAddButton(){
        openDocumentPicker()
        //        let indexPath = IndexPath(row: 0, section: 0)
        //        let cell = self.myProfileTableView.cellForRow(at: indexPath) as! MyResumeTableViewCell
        
        // cell.addButon.setTitle("View Resume", for: .normal)
    }
    @IBAction func onBackButtonPressed(_ sender: Any) {
        dismiss(animated: true)
    }
    //    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    //        let view = UIView()
    //
    //        let button = UIButton(frame: CGRect(x: UIScreen.main.bounds.size.width - 140, y: 10, width: 120, height: 40))
    //        button.setTitle("Add", for: .normal)
    //
    //        button.tag = section
    //        button.addTarget(self, action: #selector(onClickAddButton), for: .touchUpInside)
    //
    //        view.addSubview(button)
    //
    //        return view
    //    }
    @objc func onClickAddButton(){
        
    }
    
}
extension MyProfileViewController1:UITableViewDataSource,UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionArray.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return expCardData.count
        case 3:
            return educationCardData.count
        case 4:
            return myResumeArray.count
        default:
            return 1
        }
        
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = Bundle.main.loadNibNamed("MyProfileHeadeTableViewCell", owner: self, options: nil)?.first as! MyProfileHeadeTableViewCell
        if section == 0 || section == 4{
            headerView.addButton.isHidden = true
            
        }
        if section == 0 {
            headerView.contentView.backgroundColor = .white
        }
        if section != 0{
            headerView.headerView.layer.cornerRadius = 2
        headerView.headerView.layer.shadowRadius = 2
            headerView.headerView.layer.shadowOpacity = 1.0
            headerView.headerView.layer.shadowColor = UIColor.gray.cgColor
            headerView.headerView.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        }
        headerView.headerName.text = myProfileTitleArray[section]
        headerView.addButton.tag = section
        headerView.addButton.addTarget(self, action: #selector(onClickAddButton(sender:)), for: .touchUpInside)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    @objc func onClickAddButton(sender: UIButton!){
        switch sender.tag {
        case 1:
            self.performSegue(withIdentifier: "myProfileToSummary", sender: self)
        case 2:
            self.performSegue(withIdentifier: "myProfileToExperience", sender: self)
        case 3:
            self.performSegue(withIdentifier: "myProfileToEducation", sender: self)
        default:
            print("")
        }
    }
    //    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    //        switch section {
    //        case 0: return ""
    //        case 1: return "PROFILE SUMMARY"
    //        case 2: return "EXPERIENCE"
    //        case 3: return "EDUCATION"
    //        case 4: return "RESUME"
    //        default:
    //            return nil
    //        }
    //    }
    func addGesture() {
        
        
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            if let myProfileTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MyProfileTableViewCell") as? MyProfileTableViewCell {
                
                myProfileTableViewCell.userNameTextField.text = self.userData.userMetaData?.value(forKey: "name") as? String
                myProfileTableViewCell.userEmailIdTextField.text = userData.email
                myProfileTableViewCell.phoneNumberTextField.text = self.userData.userMetaData?.value(forKey: "contactNumber") as? String
                myProfileTableViewCell.userNameTextField.isUserInteractionEnabled = true
                let userNameTextfieldtap = UITapGestureRecognizer(target: self, action: #selector(self.onClickNameTextFieldtap(_:)))
                myProfileTableViewCell.userNameTextField.addGestureRecognizer(userNameTextfieldtap)
                let emailTap = UITapGestureRecognizer(target: self, action: #selector(self.onEmailTextFieldtap))
                myProfileTableViewCell.userEmailIdTextField.isUserInteractionEnabled = true
                myProfileTableViewCell.userEmailIdTextField.addGestureRecognizer(emailTap)
                let phoneNumberTap = UITapGestureRecognizer(target: self, action: #selector(self.onMobileNumberTap(_:)))
                myProfileTableViewCell.phoneNumberTextField.isUserInteractionEnabled = true
                myProfileTableViewCell.phoneNumberTextField.addGestureRecognizer(phoneNumberTap)
                return myProfileTableViewCell
            }
        case 1:
            if  let myProfileDetailTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MyProfileDetailTableViewCell") as? MyProfileDetailTableViewCell {
                
                myProfileDetailTableViewCell.myProfileDescrption.text = self.userData.userMetaData?.value(forKey: "profileSummary") as? String
                //                if indexPath.row < myProfileTitleArray.count {
                //                    //myProfileDetailTableViewCell.myProfileTitle.text = myProfileTitleArray[indexPath.row]
                //                    //myProfileDetailTableViewCell.myProfileDescrption.text = mySummaryDetails[indexPath.row]
                myProfileDetailTableViewCell.addButon.addTarget(self, action: #selector(onClickProfileSummaryAddButton), for: .touchUpInside)
                //
                //                }
                return myProfileDetailTableViewCell
                
            }
        case 2:
            if  let myExperienceTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MyExperienceTableViewCell") as? MyExperienceTableViewCell {
                print(indexPath.row)
                print(indexPath.section)
                print(myExperienceArray.count)
                // if expCardData.count == 0 {
                if indexPath.row < expCardData.count{
                    let expData = expCardData[indexPath.row]
                    myExperienceTableViewCell.editButton.tag = indexPath.row
                    myExperienceTableViewCell.jobTitleLabel.text = expData.jobTitle
                    myExperienceTableViewCell.companyLabel.text = expData.company
                    myExperienceTableViewCell.fromDateLabel.text = (expData.startDate ?? "") + " To " + (expData.endDate ?? "")
                    myExperienceTableViewCell.editButton.addTarget(self, action: #selector(onClickExperienceAddButton), for: .touchUpInside)
                }
                return myExperienceTableViewCell
                
            }
        case 3:
            if  let myEducationTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MyEducationTableViewCell") as? MyEducationTableViewCell {
                if indexPath.row < educationCardData.count {
                    let educationData = educationCardData[indexPath.row]
                    myEducationTableViewCell.degreeLabel.text = educationData.Degree
                    myEducationTableViewCell.school_CollegeLabel.text = educationData.College_School
                    myEducationTableViewCell.fromDateLabel.text = (educationData.startDate ?? "") + " To " + (educationData.endDate ?? "")
                  
                    myEducationTableViewCell.editButton.tag = indexPath.row
                    myEducationTableViewCell.editButton.addTarget(self, action: #selector(onClickEducationAddButton), for: .touchUpInside)
                    
                }
                return myEducationTableViewCell
                
            }
        case 4:
            if  let myResumeTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MyResumeTableViewCell") as? MyResumeTableViewCell {
                if indexPath.row < myResumeArray.count {
                    myResumeTableViewCell.myProfileTitle.text = myResumeArray[indexPath.row]
                    myResumeTableViewCell.myProfileDescrption.text = myResumeDetails[indexPath.row]
                    myResumeTableViewCell.addButon.addTarget(self, action: #selector(onClickResumeAddButton), for: .touchUpInside)
                }
                return myResumeTableViewCell
                
            }
        default:
            UITableViewCell()
        }
        return UITableViewCell()
    }
    
}
extension MyProfileViewController1 : DataEnteredDelegate {
    func userDidEnterInformation(info: String) {
        let indexPath = IndexPath(row: 0, section: 1)
        let cell = self.myProfileTableView.cellForRow(at: indexPath) as! MyProfileDetailTableViewCell
        cell.myProfileDescrption.text = info
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "myProfileToSummary" {
            let profileSummaryDetailsVC = segue.destination as! ProfileSummaryDetailsViewController
            profileSummaryDetailsVC.delegate = self
        }
    }
    
}

extension MyProfileViewController1:UIDocumentPickerDelegate,UINavigationControllerDelegate{
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        let myURL = url as URL
        print("import result : \(myURL)")
        uploadFilesServerCall(data: myURL)
    }
    
    
    func documentMenu(_ documentMenu:UIDocumentPickerViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
        documentPicker.delegate = self
        present(documentPicker, animated: true, completion: nil)
    }
    
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print("view was cancelled")
        dismiss(animated: true, completion: nil)
    }
    func openDocumentPicker(){
        let docMenu = UIDocumentPickerViewController(documentTypes: [String(kUTTypePDF),String(kUTTypeText),String(kUTTypePNG)], in: .import)
        docMenu.delegate = self  as UIDocumentPickerDelegate
        docMenu.modalPresentationStyle = .formSheet
        self.present(docMenu, animated: true, completion: nil)
    }
    
    func uploadFilesServerCall(data: URL){
        
        if isInternetAvailable(){
            Util.Manager.upload(
                multipartFormData: { (multipartFormData) in
                    
                    // if data1 = data1{
                    
                    //  multipartFormData.append(data, withName:"uploaded_file", mimeType:"multipart/form-data")
                    
                    multipartFormData.append(data, withName: "pdfDocuments", fileName: "pdfDocuments.pdf", mimeType:"application/pdf")
                    multipartFormData.append(data, withName: "file", fileName: "file", mimeType: "application/txt")
                    multipartFormData.append(data, withName: "file", fileName: "file", mimeType: "application/Docx")
                    //}
                    //                    if let data = selectedImgData{
                    //
                    //                        multipartFormData.append(data, withName: "image", fileName: "image.png", mimeType: "image/png")
                    //
                    //                    }
                    //
            },
                to: RESUME_UPLOAD_API,
                encodingCompletion: { encodingResult in
                    switch encodingResult {
                    case .success(let upload, _, _):
                        upload.responseJSON(completionHandler: { response in
                            print(response)
                            print("Response from the server is \(response.result)")
                            if let json = response.result.value{
                                
                                let jsonDict = json as! NSDictionary
                                if let status = jsonDict.object(forKey: "status") as? Int{
                                    if status == 200{
                                        Util.showAlert(message: (jsonDict.object(forKey: "statusText") as? String ?? ""), viewController: self, title: "Success")
                                        
                                    }else{
                                        Util.showAlert(message: (jsonDict.object(forKey: "message") as? String ?? ""), viewController: self, title: "Error")
                                    }
                                }
                            } else {
                                
                            }
                        })
                    case .failure(let encodingError):
                        print(encodingError)
                    }
            }
            )
        }else{
            Util.showWhistle(message: NO_INTERNET, viewController: self)
        }
    }
}
