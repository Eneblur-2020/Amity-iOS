//
//  CourseViewController.swift
//  Amity
//
//  Created by Snehalatha Desai on 10/07/20.
//  Copyright © 2020 Eneblur Consulting. All rights reserved.
//

import UIKit
import Alamofire


class CourseViewController:  UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var sections = ["","Browse by Topic","","Students Testimonials"]
    var sectionLabel = ["","Preview Upcoming Webinars","Upcoming Events","Recent Photos and Videos"]
    var sectionButtonArray = ["VIEW ALL","VIEW ALL",]
     var categorydata = [Courses]()
    var coursedata = [Courses]()
     
    var facultydata = [Courses.faculty]()
    var partnerslogodata = [Courses.partnerlogo]()
    var code = Int()
    var sendfacultydata = [Courses.faculty]()
     var sendpartnerslogodata = [Courses.partnerlogo]()
     var sendcoursedata = [Courses]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
        
        tableView.delegate = self
        tableView.dataSource = self
        registerTableViewcell()
        tableView.contentInset = UIEdgeInsets(top: -1, left: 0, bottom: 0, right: 0)
//         getcoursesAPI()
//        tableView.reloadData()
        
    }
    func registerTableViewcell(){
        self.tableView.register(UINib(nibName: "CourseSliderTableViewCell", bundle: nil), forCellReuseIdentifier: "CourseSliderTableViewCell")
        self.tableView.register(UINib(nibName: "TopicSliderTableViewCell", bundle: nil), forCellReuseIdentifier: "TopicSliderTableViewCell")
        self.tableView.register(UINib(nibName: "InfoTableViewCell", bundle: nil), forCellReuseIdentifier: "InfoTableViewCell")
        self.tableView.register(UINib(nibName: "TestiTableViewCell", bundle: nil), forCellReuseIdentifier: "TestiTableViewCell")
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        getcoursesAPI()
        getcoursescategoryAPI()
        tableView.reloadData()
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
                   
              print("url :",GET_COURSES_API)
                   if isInternetAvailable(){
                     Util.Manager.request(GET_COURSES_API, method : .get, encoding: JSONEncoding.default).responseJSON { (response) in
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
    
    func getcoursescategoryAPI(){
                     
                     if(categorydata.count > 0)
                     {
                         categorydata.removeAll()
                     }
                     
                print("url :",GET_COURSECATEGORY_API)
                     if isInternetAvailable(){
                       Util.Manager.request(GET_COURSECATEGORY_API, method : .get, encoding: JSONEncoding.default).responseJSON { (response) in
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
                                                                                course.categorycode = i.value(forKey: "code") as? Int
                                                                                course.categoryname = i.value(forKey: "displayName") as? String
                                                                                  
                                                                                 self.categorydata.append(course)
                                                                                 
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
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 || section == 2
        {
             return nil
        }
        else
        {
        let view = UIView()
        view.backgroundColor = UIColor.white
        let label = UILabel()
        label.textColor = UIColor(named: "TitleBlackColour")
        label.frame = CGRect(x: 27, y: 10, width: 400, height: 20)
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.text = sections[section]
        view.addSubview(label)
            
//        let detailLabel = UILabel()
//        detailLabel.textColor = UIColor(named: "GreyColour")
//        detailLabel.frame = CGRect(x: 20, y: 40, width: 400, height: 40)
//        detailLabel.numberOfLines = 0
//        detailLabel.lineBreakMode = .byWordWrapping
//        detailLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
//        detailLabel.text = sectionLabel[section]
//        view.addSubview(label)
//        view.addSubview(detailLabel)
//
//
//        let button = UIButton(frame: CGRect(x: UIScreen.main.bounds.size.width - 140, y: 10, width: 120, height: 40))
//        button.setTitle("VIEW ALL", for: .normal)
//        button.cornerRadius = 10
//        button.setTitleColor(UIColor(named: "DarkBlueColour"), for: .normal)
//        button.tag = section
//        button.addTarget(self, action: #selector(onClickViewAllButton), for: .touchUpInside)
//
//        button.backgroundColor = UIColor(named: "DarkYellowColour")
//        view.addSubview(button)
        
        return view
        }
        
    }
    @objc func onClickViewAllButton(){
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 280
        }
            else  if  indexPath.section == 2
        {
            return 207
        }
            else  if  indexPath.section == 3
                  {
                      return 193
                  }
            else  if  indexPath.section == 2
                             {
                                 return 402
                             }
        else{
            return 350
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 || section == 2
        {
            return 0
        }
        else{
            return 40
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            
             if let cell = tableView.dequeueReusableCell(withIdentifier: "CourseSliderTableViewCell") as? CourseSliderTableViewCell {
                if(cell.coursedata.count>0)
                {
                    cell.coursedata.removeAll()
                }
           cell.coursedata.append(contentsOf: coursedata)
                cell.sliderCollectionView.reloadData()
               
                
                 cell.course_Action = {
                                
             
                    if self.sendfacultydata.count > 0
                                   {
                                       self.sendfacultydata.removeAll()
                                   }
                                   if self.sendpartnerslogodata.count > 0
                                                  {
                                                      self.sendpartnerslogodata.removeAll()
                                                  }
                    
                    if self.sendcoursedata.count > 0
                                                                     {
                                                                         self.sendcoursedata.removeAll()
                                                                     }
                    self.sendfacultydata.append(contentsOf: cell.facultydata)
                    self.sendpartnerslogodata.append(contentsOf: cell.partnerslogodata)
                    self.sendcoursedata.append(contentsOf: cell.coursedataitem)
                   self.nextpage(segue: "coursedetails")
                   // self.coursedetailpage()
                            }
            return cell
            }
        case 1:
         
            if let cell = tableView.dequeueReusableCell(withIdentifier: "TopicSliderTableViewCell") as? TopicSliderTableViewCell {
                if(cell.coursedata.count>0)
                               {
                                   cell.coursedata.removeAll()
                               }
                cell.coursedata.append(contentsOf: self.categorydata)
                cell.topicCollectionView.reloadData()
            cell.topic_Action = {
                

                self.code = cell.selectedcode
                self.nextpage(segue:"topicdetails")
            }
            return cell
            }
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier:"InfoTableViewCell" ) as! InfoTableViewCell
            return cell
        case 3:
             let cell = tableView.dequeueReusableCell(withIdentifier:"TestiTableViewCell" ) as! TestiTableViewCell
            return cell
        default:
            UITableViewCell()
        }
        
        return UITableViewCell()
        
    }
    //topicdetails
    func nextpage(segue: String)
    {
        performSegue(withIdentifier: segue, sender: AnyObject.self)
    }
    func coursedetailpage()
    {
     if let nextViewController =   self.storyboard?.instantiateViewController(withIdentifier: "CourseDetailViewController") as? CourseDetailViewController {
        //nextViewController.finacerId = idArray[indexPath.row]
        nextViewController.facultydata.append(contentsOf: sendfacultydata)
         nextViewController.partnerslogodata.append(contentsOf: sendpartnerslogodata)
        nextViewController.coursedata.append(contentsOf: sendcoursedata)
        
        nextViewController.modalPresentationStyle = .formSheet
        self.navigationController?.pushViewController(nextViewController, animated: true)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       // Get the new view controller using segue.destination.
       // Pass the selected object to the new view controller.
           
               
        if segue.identifier == "topicdetails" {
          let vc = segue.destination as! TopicViewController
             
            vc.cat_code = self.code
            
          // vc.grandtotal.text = "Grand total :" + String(gtotal)


               }
        if segue.identifier == "coursedetails" {
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
                 nextViewController.facultydata.append(contentsOf: sendfacultydata)
                        nextViewController.partnerslogodata.append(contentsOf: sendpartnerslogodata)
                       nextViewController.coursedata.append(contentsOf: sendcoursedata)
                       


                      }
       
           }
           
}

