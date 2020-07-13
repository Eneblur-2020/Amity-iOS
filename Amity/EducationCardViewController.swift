//
//  EducationCardViewController.swift
//  Amity
//
//  Created by Vinayak Tudayekar on 04/07/20.
//  Copyright © 2020 Eneblur Consulting. All rights reserved.
//

import UIKit
import Alamofire
protocol EducationDelegate: class {
    func educationInformation(educationCardData: MyEducation)
}


class EducationCardViewController: UIViewController {
    
    @IBOutlet var tableVew: UITableView!
    var educationCardData = [MyEducation]()
    var educationDelegate: EducationDelegate? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
                intialSetUp()
        
        getDetails(url: EDUCATION_API)
    }
    
    func intialSetUp(){
        self.title = "EDUCATION"
        let addButtonItem = UIBarButtonItem(title: "Add", style: .done, target: self, action: #selector(onClickAddButton))
        self.navigationItem.rightBarButtonItem  = addButtonItem
    }
    @objc func onClickAddButton(){
        if let lastSubmittedData = educationCardData.last{
        educationDelegate?.educationInformation(educationCardData:lastSubmittedData)
        self.navigationController?.popViewController(animated: true)
    }
    }
    
   func getDetails(url:String){
        
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
                                        
                                            myEducation.startDate = Helper.dateFormatterMMMyyyy(dateString:  i.value(forKey: "fromDate") as? String ?? "")
                                            myEducation.endDate = Helper.dateFormatterMMMyyyy(dateString:  i.value(forKey: "toDate") as? String ?? "")
                                       
                                            self.educationCardData.append(myEducation)
                                            
                                        }
                                         self.tableVew.reloadData()
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
    @IBAction func onBackButtonPressed(_ sender: Any) {
        dismiss(animated: true)
    }
    @IBAction func onSaveButtonClick(_ sender: Any) {
        //self.performSegue(withIdentifier: "SaveExpToExpCard", sender: self)
        
        
    }
    
    
}
extension EducationCardViewController: UITableViewDataSource,UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return educationCardData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let educationCardTableViewCell = tableView.dequeueReusableCell(withIdentifier: "EducationCardTableViewCell") as? EducationCardTableViewCell {
            let card = educationCardData[indexPath.row]
            educationCardTableViewCell.degreeLabel?.text = card.Degree
            educationCardTableViewCell.school_CollegeLabel.text = card.College_School
            educationCardTableViewCell.startDateLabel.text = (card.startDate ?? "") + " To " + (card.endDate ?? "")
            
            return educationCardTableViewCell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
