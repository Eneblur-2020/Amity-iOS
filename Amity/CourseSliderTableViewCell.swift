//
//  CourseSliderTableViewCell.swift
//  Amity
//
//  Created by Snehalatha Desai on 10/07/20.
//  Copyright © 2020 Eneblur Consulting. All rights reserved.
//

import UIKit
import Alamofire

class CourseSliderTableViewCell:  UITableViewCell,UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var sliderCollectionView: UICollectionView!
    @IBOutlet weak var pageOutlet: UIPageControl!
    var course_Action: (() -> Void)? = nil
    var coursedata = [Courses]()
        
    var facultydata = [Courses.faculty]()
    var partnerslogodata = [Courses.partnerlogo]()
    
    
    
 var coursedataitem = [Courses]()
    
       //var timer : Timer!
    var arrayOfImages = ["screen1","screen2","screen3","screen4","screen5"]
   
    override func awakeFromNib() {
        super.awakeFromNib()
        self.sliderCollectionView.register(UINib(nibName: "CourseSliderCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CourseSliderCollectionViewCell")
        self.sliderCollectionView.delegate = self
        self.sliderCollectionView.dataSource = self
        pageOutlet.currentPageIndicatorTintColor = UIColor(named: "DarkBlueColour")
        pageOutlet.pageIndicatorTintColor = UIColor(named: "DarkYellowColour")
       Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(scrollAutomatically(_:)), userInfo: nil, repeats: true)
    // getcoursesAPI()
         self.sliderCollectionView.reloadData()
        // Initialization code
    }

   func getcoursesAPI(){
                
                
                
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
                                                                             if let faculty = i.object(forKey: "faculty") as? NSArray{
                                                                               for fac in faculty
                                                                               {
                                                                                    let i = fac as! NSDictionary
                                                                                   //description
                                                                          course.facultyname = i.value(forKey: "name") as? String
                                                                               }
                                                                               
                                                                           }
//                                                                           if let coursedetail = i.object(forKey: "courseImage") as? NSArray{
//                                                                                for fac in coursedetail
//                                                                                {
//                                                                                     let i = fac as! NSDictionary
//                                                                                    //description
//                                                                           course.courseimg = i.value(forKey: "url") as? String
//                                                                                }
//
//                                                                            }
                                                                             self.coursedata.append(course)
                                                                            print("response here",self.coursedata)
                                                                         }
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
                    //Util.showWhistle(message: NO_INTERNET, viewController: CourseViewController.self)
                }
       }
          
     
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func changePage(_ sender: UIPageControl) {
        print(pageOutlet.currentPage)
        sliderCollectionView.scrollRectToVisible(CGRect(x : Int(self.sliderCollectionView.frame.size.width) * self.pageOutlet.currentPage,y
            : 0,width : Int(self.sliderCollectionView.frame.size.width),height : Int(self.sliderCollectionView.frame.size.height
                
        )), animated: true)

    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let data = coursedata[indexPath.item]
        
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
     
        
       course_Action?()
       }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: sliderCollectionView.frame.width , height: sliderCollectionView.frame.height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.coursedata.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CourseSliderCollectionViewCell", for: indexPath) as! CourseSliderCollectionViewCell
        
        let data = self.coursedata[indexPath.item]
       // cell.coursesliderImage.image = UIImage.init(data: <#T##Data#>)
        cell.coursename.text = data.coursename
        cell.facultyname.text = "Faculty :" + data.facultyname!
       cell.duration.text = "Duration :" + data.duration!
   cell.coursesliderImage.imageFromServer(urlString: data.courseimg!)
        return cell
    }
        
    @objc func scrollAutomatically(_ timer1: Timer) {
        if let temporaryView  = sliderCollectionView {
            for cell in temporaryView.visibleCells {
                let indexPath: IndexPath? = temporaryView.indexPath(for: cell)
                if ((indexPath?.item)!  < self.coursedata.count - 1){
                    let temporaryIndexPath: IndexPath?
                    print(indexPath!)
                    temporaryIndexPath = IndexPath.init(row: (indexPath?.row)! + 1, section: (indexPath?.section)!)
                    temporaryView.scrollToItem(at: temporaryIndexPath!, at: .right, animated: true)
                }
                else{
                    let temporaryIndexPath: IndexPath?
                    print(indexPath!)
                    temporaryIndexPath = IndexPath.init(row: 0, section: (indexPath?.section)!)
                    temporaryView.scrollToItem(at: temporaryIndexPath!, at: .left, animated: true)
                }
                
            }
        }
    }
    
} // main class close

extension CourseSliderTableViewCell : UIPageViewControllerDelegate{
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.pageOutlet.currentPage = indexPath.item
    }
    
    func CourseSliderTableViewCell(_ scrollView: UIScrollView) {
        pageOutlet.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
}


