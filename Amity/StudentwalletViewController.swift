//
//  StudentwalletViewController.swift
//  Amity
//
//  Created by Snehalatha Desai on 21/07/20.
//  Copyright © 2020 Eneblur Consulting. All rights reserved.
//

import UIKit
import Alamofire
class StudentwalletViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier:"StudentWalletTableViewCell" ) as! StudentWalletTableViewCell
        
        cell.titlelabel.text = "Introduction to Product management"
                   return cell
        
        
    }
    

     @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
               tableView.dataSource = self
             
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        getstudentwalletAPI()
        
    }
    
    func getstudentwalletAPI(){
                 
                
                 
            print("url :",GET_STUDENTWALLET_API)
                 if isInternetAvailable(){
                   Util.Manager.request(GET_STUDENTWALLET_API, method : .get, encoding: JSONEncoding.default).responseJSON { (response) in
                         switch response.result{
                         case .success(_):
                             if let json = response.result.value{
                                 if let jsonData = json as? NSDictionary {
                                     if let status = jsonData.object(forKey: "status") as? Int {
                                         
                                       if status == 200
                                       {
                                        print("response here",jsonData)
    //
//                                        if let data = jsonData.object(forKey: "data") as? NSArray{
//                                                                          for exp in data {
//                                                                              let course = Courses()
//                                                                              let i = exp as! NSDictionary
//                                                                            course.categorycode = i.value(forKey: "code") as? Int
//                                                                            course.categoryname = i.value(forKey: "displayName") as? String
//
//                                                                              self.categorydata.append(course)
//
                                                                          //}
                                      //  }
                                       }
                                     }
                                 }
                             }
                          //   self.tableView.reloadData()
                             break
                         case .failure(_):
                             if let statusCode = response.response?.statusCode {
                                 
                             }
                             break
                             
                         }
                     }
                 } else {
                     //Util.showWhistle(message: NO_INTERNET, viewController: CourseViewController.self)
                 }
        }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
