//
//  ExpCardViewController.swift
//  Amity
//
//  Created by swapna raddi on 01/06/20.
//  Copyright © 2020 Eneblur Consulting. All rights reserved.
//

import UIKit
import Alamofire

struct ExpCard:Codable {
    var jobTitle: String
    var company: String
    var fromDate: String
    // var toDate: String
}
protocol ExperienceDelegate {
    func experienceInformation(experienceCardData: MyExperince)
}
class ExpCardViewController: UIViewController {
    
    //    let expCardView = [
    //        ExpCard(jobTitle: "Ios Developer", company: "Eneblur", fromDate: "11/02/19 To 12/05/2020"),
    //        ExpCard(jobTitle: "Python Developer", company: "IBM", fromDate: "01/01/18 To 01/05/2020")
    //    ]
    var expCardData = [MyExperince]()
    var experienceArray = [String:AnyObject]()
    var experienceDelegate : ExperienceDelegate? = nil
    @IBOutlet var tableVew: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        intialSetUp()
        getDetails(url: EXPERIENCE_API)
    }
    
    func intialSetUp(){
         self.title = "EXPERIENCE"
        let addButtonItem = UIBarButtonItem(title: "Add", style: .done, target: self, action: #selector(onClickAddButton))
        self.navigationItem.rightBarButtonItem  = addButtonItem
    }
    @objc func onClickAddButton(){
        if let lastdata = expCardData.last  {
            experienceDelegate?.experienceInformation(experienceCardData: lastdata)
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
                            self.expCardData.removeAll()
                                if status == 200 {
                                    if let data = jsonData.object(forKey: "data") as? NSArray{
                                        for exp in data {
                                        let myExp = MyExperince()
                                            let i = exp as! NSDictionary
                                        myExp.jobTitle = i.value(forKey: "jobTitle") as? String
                                        myExp.company = i.value(forKey: "company") as? String
                                        myExp.city = i.value(forKey: "city") as? String
                                          myExp.startDate =    Helper.dateFormatterMMMyyyy(dateString: i.value(forKey: "fromDate") as? String ?? "")
                                        let endDate = i.value(forKey: "toDate") as? String ?? ""
                                        if endDate != "Present"{
                                        myExp.endDate = Helper.dateFormatterMMMyyyy(dateString: endDate)
                                        } else {
                                             myExp.endDate = endDate
                                        }
                                         self.expCardData.append(myExp)
                                            
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
extension ExpCardViewController: UITableViewDataSource,UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expCardData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let experienceCardTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ExperienceCardTableViewCell") as? ExperienceCardTableViewCell {
            
            
            let card = expCardData[indexPath.row]
            experienceCardTableViewCell.companyNameLabel?.text = card.company
            experienceCardTableViewCell.jobTitleLabel.text = card.jobTitle
            experienceCardTableViewCell.startDateLabel.text = (card.startDate ?? "") + " To " + (card.endDate ?? "")
            
            return experienceCardTableViewCell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
