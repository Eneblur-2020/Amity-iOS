//
//  TopicViewController.swift
//  Amity
//
//  Created by Snehalatha Desai on 11/07/20.
//  Copyright © 2020 Eneblur Consulting. All rights reserved.
//

import UIKit
import Alamofire
class TopicViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource {
   
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
     var categorydata = [Courses]()
    var sections = ["","Browse by Topic","","Students Testimonials"]
    var sectionLabel = ["","Preview Upcoming Webinars","Upcoming Events","Recent Photos and Videos"]
    var sectionButtonArray = ["VIEW ALL","VIEW ALL",]
     var coursedata = [Courses]()
    var cat_code = Int()
    let picker = UIPickerView()
    var arrayOfCountries = ["All Courses","Free Courses","Paid Courses"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.delegate = self
        tableView.dataSource = self
        registerTableViewcell()
        tableView.contentInset = UIEdgeInsets(top: -1, left: 0, bottom: 0, right: 0)
        createPickerView()
               createToolbar()
        
    }
    func createPickerView()
        {
            picker.delegate = self
            picker.delegate?.pickerView?(picker, didSelectRow: 0, inComponent: 0)
            textField.inputView = picker
        
        }
      

        
        func createToolbar()
        {
            let toolbar = UIToolbar()
            toolbar.sizeToFit()
            toolbar.tintColor = UIColor.red
            toolbar.backgroundColor = UIColor.white
            let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(TopicViewController.closePickerView))
            toolbar.setItems([doneButton], animated: false)
            toolbar.isUserInteractionEnabled = true
            textField.inputAccessoryView = toolbar
           
        }
        
        @objc func closePickerView()
        {
           
            if (textField.text?.elementsEqual("Free Courses"))!
            {
                
                   getcoursesAPI()
                                      
                
            coursedata = coursedata.filter {
             //  $0.fees?.elementsEqual("0") != nil
                Int($0.fees!) == 0
            }
            }
            else if (textField.text?.elementsEqual("Paid Courses"))!
            {
                   getcoursesAPI()
                coursedata = coursedata.filter {
                //   $0.fees?.elementsEqual("0") == nil
                    Int($0.fees!)! > 0
                    
                    }
                }
                
            
            else
            {
                getcoursesAPI()
                       tableView.reloadData()
            }
            tableView.reloadData()
        
            view.endEditing(true)
        }

        
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            
            return arrayOfCountries.count
        }
        
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
        {
            return arrayOfCountries[row]
        }
        
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            
            textField.text =  arrayOfCountries[row]
        }
        
        func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
            return 100.0
        }
        
        func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
            return 40.0
        }

        func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {

            var label:UILabel
            
            if let v = view as? UILabel{
                label = v
            }
            else{
                label = UILabel()
            }
            
            label.textColor = UIColor.black
            label.textAlignment = .left
            label.font = UIFont(name: "Arial", size: 16)
            
            label.text = arrayOfCountries[row]
            
            return label
        }
    
    override func viewWillAppear(_ animated: Bool) {
        
        getcoursesAPI()
        tableView.reloadData()
    }
    func registerTableViewcell(){
        self.tableView.register(UINib(nibName: "TopicTableViewCell", bundle: nil), forCellReuseIdentifier: "TopicTableViewCell")
        
        
        
    }
    func getcoursesAPI(){
                      
                      
           if(coursedata.count > 0)
           {
               coursedata.removeAll()
           }
//        let data : [String : Int] = [
//                   "code" : cat_code]
                      
                
        let param = String.init(format: "?category=%d", cat_code)
        let urlstr = GET_COURSES_API + param
         print("url :",urlstr)
                      if isInternetAvailable(){
                        Util.Manager.request(urlstr, method : .get, encoding: JSONEncoding.default).responseJSON { (response) in
                              switch response.result{
                              case .success(_):
                                  if let json = response.result.value{
                                      if let jsonData = json as? NSDictionary {
                                          if let status = jsonData.object(forKey: "status") as? Int {
                                              
                                            if status == 200
                                            {
         //
                                             if let data = jsonData.object(forKey: "data") as? NSArray{
                                               for exp in data {
                                                   let course = Courses()
                                                   let i = exp as! NSDictionary
                                                 course.coursename = i.value(forKey: "courseName") as? String
                                                 course.duration = i.value(forKey: "duration") as? String
                                                course.fees = i.value(forKey: "fees") as? String
                                                course.batchdate = Helper.dateFormatterdatemonth(dateString:i.value(forKey: "date") as? String ?? "")
                                                   if let faculty = i.object(forKey: "faculty") as? NSArray{
                                                     for fac in faculty
                                                     {
                                                          let i = fac as! NSDictionary
                                                         //description
                                                course.facultyname = i.value(forKey: "name") as? String
                                                     }
                                                     
                                                 }
                                                 if let coursedetail = i.object(forKey: "courseImage") as? NSDictionary{
                                                     
                                                          // let i = fac as! NSDictionary
                                                          //description
                                                 course.courseimg = coursedetail.value(forKey: "url") as? String
                                                      
                                                      
                                                  }
                                                   self.coursedata.append(course)
                                                  print("response here",self.coursedata)
                                               }
                                                                               
                                             }
                                            }
                                          }
                                      }
                                  }
                                  self.tableView.reloadData()
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
       
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    @objc func onClickViewAllButton(){
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       
            return 150
        
    }
    
  
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coursedata.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       
            let cell = tableView.dequeueReusableCell(withIdentifier: "TopicTableViewCell") as! TopicTableViewCell
        let data = coursedata[indexPath.row]
        cell.coursename.text = data.coursename
        cell.batchdate.text = "BatchDate : " + data.batchdate!
        cell.duration.text = "Duration : " + data.duration!
        cell.facultyname.text = "Faculty : " + data.facultyname!
        cell.coursesliderImage.imageFromServer(urlString: data.courseimg!)
            return cell
        
    }
}

