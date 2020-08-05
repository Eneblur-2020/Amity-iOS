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
    @IBOutlet weak var noitemsview: UIView!
     var categorydata = [Courses]()
    var sections = ["","Browse by Topic","","Students Testimonials"]
    var sectionLabel = ["","Preview Upcoming Webinars","Upcoming Events","Recent Photos and Videos"]
    var sectionButtonArray = ["VIEW ALL","VIEW ALL",]
     var coursedata = [Courses]()
    var cat_code = Int()
    let picker = UIPickerView()
    var arrayOfCountries = ["All Courses","Free Courses","Paid Courses"]
    var check = String()
     var sorteddata = [Courses]()
    
    var facultydata = [Courses.faculty]()
    var partnerslogodata = [Courses.partnerlogo]()
    var code = Int()
    var sendfacultydata = [Courses.faculty]()
     var sendpartnerslogodata = [Courses.partnerlogo]()
     var sendcoursedata = [Courses]()
 var coursedataitem = [Courses]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.delegate = self
        tableView.dataSource = self
        registerTableViewcell()
      //  tableView.backgroundView = self.noitemsview
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
                
               //    getcoursesAPI()
                if sorteddata.count > 0
                {
                    sorteddata.removeAll()
                }
                                      
                check = "free"
                
            sorteddata = coursedata.filter {
             //  $0.fees?.elementsEqual("0") != nil
                Int($0.fees!) == 0
            }
            }
            else if (textField.text?.elementsEqual("Paid Courses"))!
            {
                  // getcoursesAPI()
                if sorteddata.count > 0
                {
                    sorteddata.removeAll()
                }
                check = "paid"
                sorteddata = coursedata.filter {
                //   $0.fees?.elementsEqual("0") == nil
                    Int($0.fees!)! > 0
                    
                    }
                }
                
            
            else
            {
                check = "all"
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
           if(facultydata.count > 0)
           {
               facultydata.removeAll()
           }
           if(partnerslogodata.count > 0)
           {
               partnerslogodata.removeAll()
           }
                   
        let param = String.init(format: "?category=%d", cat_code)
               let urlstr = GET_COURSES_API + param
                 print("url :",GET_COURSES_API)
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
                                                   course.learningoutcome = i.value(forKey: "learningOutcome") as? String
                                                    course.fees = i.value(forKey: "fees") as? String
                                                    course.video = i.value(forKey: "shortCoursesURL") as? String
                                                    course.coursesurl = i.value(forKey: "coursesURL") as? String
                                                    course.courseid = i.value(forKey: "_id") as? String
                                                   course.batchdate = Helper.dateFormatterdatemonth(dateString:i.value(forKey: "date") as? String ?? "")
                                                   //coursesURL
                                                   //fetch faculty
                                                   if let faculty = i.object(forKey: "faculty") as? NSArray{
                                                     for fac in faculty
                                                     {
                                                          let i = fac as! NSDictionary
                                                course.facultyname = i.value(forKey: "name") as? String
                                                       let facname = i.value(forKey: "name") as? String
                                                       var facimg = String()
                                                       if let coursedetail = i.object(forKey: "image") as? NSDictionary{
                                                                         course.facultyimg = coursedetail.value(forKey: "url") as? String
                                                                                                         
                                                           facimg = coursedetail.value(forKey: "url") as! String
                                                           
                                                                                                     }
                                                      
                                                         let facdesc = i.value(forKey: "description") as? String

                                                       let facdata = Courses.faculty.init(fname: facname, fimg: facimg, fdesc: facdesc)
                                                     
                                                       
                                                       self.facultydata.append(facdata)
                                                     }
                                                     
                                                 }
                                                   //fetch partnerslogo
                                                   if let faculty = i.object(forKey: "partnerUniversityLogo") as? NSArray{
                                                                                                    for fac in faculty
                                                                                                    {
                                                                                                         let i = fac as! NSDictionary
                                                                                                        //description
                                                                                               let pimg = i.value(forKey: "url") as? String
                                                                                                     
                                                                                                     let facdata = Courses.partnerlogo.init(pimg: pimg)
                                                                                                       
                                                                                                                                                         self.partnerslogodata.append(facdata)
                                                                                                    }
                                                                                                    
                                                                                                }
                                                   
                                                   /*
                                                    "learningOutcome": "Abc",
                                                    "partnerUniversityLogo": [
                                                    curriculumFile
                                                    sampleCertificate
                                                    */
                                                   
                                                 if let coursedetail = i.object(forKey: "courseImage") as? NSDictionary{
                                                     
                                                          // let i = fac as! NSDictionary
                                                          //description
                                                 course.courseimg = coursedetail.value(forKey: "url") as? String
                                                      
                                                      
                                                  }
                                                   if let coursedetail = i.object(forKey: "sampleCertificate") as? NSDictionary{
                                                                                                   
                                   
                                                                                               course.certificate = coursedetail.value(forKey: "url") as? String
                                                                                                    
                                                                                                    
                                                                                                }
                                                   if let coursedetail = i.object(forKey: "curriculumFile") as? NSDictionary{
                                                                                                                                                                     course.curriculum = coursedetail.value(forKey: "url") as? String
                                                                                                                           }
                                                   
                                                   
                                                   course.partnerslogodata.append(contentsOf: self.partnerslogodata)
                                                    course.facultydata.append(contentsOf: self.facultydata)
                                                   self.coursedata.append(course)
                                                   if(self.facultydata.count > 0)
                                                                                                     {
                                                                                                         self.facultydata.removeAll()
                                                                                                       
                                                                                                     }
                                                   if(self.partnerslogodata.count > 0)
                                                                                                     {
                                                                                                         self.partnerslogodata.removeAll()
                                                                                                       
                                                                                                     }
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
                          //Util.showWhistle(message: NO_INTERNET, viewController: CourseViewController.self)
                      }
             }
       
    func getcoursesAPI2(){
                      
                      
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
       var numOfSection: NSInteger = 0
       
        if sorteddata.count > 0 || coursedata.count > 0 {

            self.tableView.backgroundView = nil
            numOfSection = 1
                }
        
         else {

            let noDataLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.tableView.bounds.size.width, height: self.tableView.bounds.size.height))
            noDataLabel.text = "No Data Available"
            noDataLabel.textColor = UIColor(red: 22.0/255.0, green: 106.0/255.0, blue: 176.0/255.0, alpha: 1.0)
            noDataLabel.textAlignment = NSTextAlignment.center
            self.tableView.backgroundView = noDataLabel

        }
        return numOfSection
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       
            return 150
        
    }
    
  
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if check == "free" || check == "paid"
        {
            return sorteddata.count
        }
        else
        {
        return coursedata.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       
            let cell = tableView.dequeueReusableCell(withIdentifier: "TopicTableViewCell") as! TopicTableViewCell
        if check == "free" || check == "paid"
               {
                let data = sorteddata[indexPath.row]
                cell.coursename.text = data.coursename
                cell.batchdate.text = "BatchDate : " + data.batchdate!
                cell.duration.text = "Duration : " + data.duration!
                cell.facultyname.text = "Faculty : " + data.facultyname!
                cell.coursesliderImage.imageFromServer(urlString: data.courseimg!)
        }
        else
        {
        let data = coursedata[indexPath.row]
        cell.coursename.text = data.coursename
        cell.batchdate.text = "BatchDate : " + data.batchdate!
        cell.duration.text = "Duration : " + data.duration!
        cell.facultyname.text = "Faculty : " + data.facultyname!
        cell.coursesliderImage.imageFromServer(urlString: data.courseimg!)
        }
            return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if check == "free" || check == "paid"
                      {
                       let data = sorteddata[indexPath.row]
                        if coursedataitem.count > 0
                            {
                                coursedataitem.removeAll()
                            }
                            if partnerslogodata.count > 0
                                   {
                                       partnerslogodata.removeAll()
                                   }
                            if facultydata.count > 0
                                   {
                                       facultydata.removeAll()
                                   }
                            
                            
                            
                            coursedataitem.append(data)
                        
                            partnerslogodata.append(contentsOf: data.partnerslogodata)
                            facultydata.append(contentsOf: data.facultydata)
                        self.performSegue(withIdentifier: "coursedetails2", sender: self)
        }
        else
        {
            let data = coursedata[indexPath.row]
            if coursedataitem.count > 0
                {
                    coursedataitem.removeAll()
                }
                if partnerslogodata.count > 0
                       {
                           partnerslogodata.removeAll()
                       }
                if facultydata.count > 0
                       {
                           facultydata.removeAll()
                       }
                
                
                
                coursedataitem.append(data)
            
                partnerslogodata.append(contentsOf: data.partnerslogodata)
                facultydata.append(contentsOf: data.facultydata)
            self.performSegue(withIdentifier: "coursedetails2", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // Get the new view controller using segue.destination.
    // Pass the selected object to the new view controller.
        
     if segue.identifier == "coursedetails2" {
              let nextViewController = segue.destination as! CourseDetailsTableViewController
                 
         if  nextViewController.facultydata.count > 0
                                          {
                                               nextViewController.facultydata.removeAll()
                                          }
                                          if nextViewController.partnerslogodata.count > 0
                                                         {
                                                             nextViewController.partnerslogodata.removeAll()
                                                         }
                           
                           if  nextViewController.coursedata.count > 0
                                                                            {
                                                                                 nextViewController.coursedata.removeAll()
                                                                            }
              nextViewController.facultydata.append(contentsOf: facultydata)
                     nextViewController.partnerslogodata.append(contentsOf: partnerslogodata)
                    nextViewController.coursedata.append(contentsOf: coursedataitem)
                    


                   }
    
        }
}

