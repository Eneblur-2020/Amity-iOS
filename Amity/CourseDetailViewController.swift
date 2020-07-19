//
//  CourseDetailViewController.swift
//  Amity
//
//  Created by Snehalatha Desai on 16/07/20.
//  Copyright © 2020 Eneblur Consulting. All rights reserved.
//

import UIKit

class CourseDetailViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource {

     @IBOutlet weak var tableView: UITableView!
     @IBOutlet weak var collectionview: UICollectionView!
    
    @IBOutlet weak var coursesliderImage: UIImageView!
    @IBOutlet weak var coursename: UILabel!
    @IBOutlet weak var duration: UILabel!
     @IBOutlet weak var batchdate: UILabel!
      @IBOutlet weak var loutcome: UILabel!
    
    
    
    
    @IBOutlet weak var freebtn: UIButton!
    @IBOutlet weak var interbtn: UIButton!
     @IBOutlet weak var interbtn2: UIButton!
    
    @IBOutlet weak var curview: UIView!
      @IBOutlet weak var certview: UIView!
      @IBOutlet weak var videoview: UIView!
    
    
    var coursedata = [Courses]()
        
    var facultydata = [Courses.faculty]()
    var partnerslogodata = [Courses.partnerlogo]()
    
 var cururl = String()
    var certurl = String()
    var videourl = String()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if coursedata.count != 0
        {
            let data = coursedata[0]
           // coursesliderImage.imageFromServer(urlString: data.courseimg!)
            coursename.text = data.coursename
            duration.text = data.duration
            batchdate.text = data.batchdate
            loutcome.text = data.learningoutcome
            
            cururl = data.curriculum!
            certurl = data.certificate!
            videourl = data.video!
            
             
        }
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.collectionview.delegate = self
        self.collectionview.dataSource = self
        registerTableViewcell()
        // Do any additional setup after loading the view.
        
        
    }
    func registerTableViewcell(){
           self.tableView.register(UINib(nibName: "CoursedetailTableViewCell", bundle: nil), forCellReuseIdentifier: "CoursedetailTableViewCell")
        self.collectionview.register(UINib(nibName: "CoursedetailCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CoursedetailCollectionViewCell")
           
           
           
       }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
           
            let view = UIView()
            view.backgroundColor = UIColor.white
            let label = UILabel()
            label.textColor = UIColor(named: "TitleBlackColour")
            label.frame = CGRect(x: 27, y: 10, width: 400, height: 20)
            label.font = UIFont.boldSystemFont(ofSize: 20.0)
            label.text = "Faculties"
            view.addSubview(label)
                
            return view
            
            
        }
    
    
     func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            if indexPath.section == 0{
                return 280
            }
                else  if  indexPath.section == 2
            {
                return 185
            }
                else  if  indexPath.section == 3
                      {
                          return 193
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
            return facultydata.count
        }
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
           
                
                 if let cell = tableView.dequeueReusableCell(withIdentifier: "facultycell") as? CoursedetailTableViewCell  {
               
                    let data = facultydata[indexPath.row]
                    
                   // cell.fimage.imageFromServer(urlString: data.fimg!)
                    cell.fname.text = data.fname
                    cell.fdescr.text = data.fdesc
                    
                return cell
            }
            return UITableViewCell()
    }
    
    
    //Collectionview
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120.0 , height: 60.0)
     }
     
     
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return partnerslogodata.count
     }
     
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "partnerslogocell", for: indexPath) as! CoursedetailCollectionViewCell
         
        let data = partnerslogodata[indexPath.item]
        
//
  // cell.partnerimage.imageFromServer(urlString: data.pimg!)
        return cell
     }
         
     @objc func scrollAutomatically(_ timer1: Timer) {
         if let temporaryView  = collectionview {
             for cell in temporaryView.visibleCells {
                 let indexPath: IndexPath? = temporaryView.indexPath(for: cell)
                 if ((indexPath?.item)!  < self.partnerslogodata.count - 1){
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
     
    
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
