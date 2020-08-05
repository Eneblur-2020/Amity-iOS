//
//  CourseDetailsTableViewController.swift
//  Amity
//
//  Created by Snehalatha Desai on 17/07/20.
//  Copyright © 2020 Eneblur Consulting. All rights reserved.
//

import UIKit

class CourseDetailsTableViewController: UITableViewController,UICollectionViewDelegate,UICollectionViewDataSource {

 //   @IBOutlet  var tableView: UITableView!
        @IBOutlet weak var partnercollectionview: UICollectionView!
       @IBOutlet weak var facultycollectionview: UICollectionView!
       @IBOutlet weak var coursesliderImage: UIImageView!
       @IBOutlet weak var coursename: UILabel!
       @IBOutlet weak var duration: UILabel!
        @IBOutlet weak var batchdate: UILabel!
         
     @IBOutlet weak var loutcome: UITextView!
    
       
       
       
       
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
       
       var courseid = String()
      var coursesurl = String()
      var fees = String()
    override func viewDidLoad() {
        super.viewDidLoad()

        if coursedata.count != 0
        {
            let data = coursedata[0]
        coursesliderImage.imageFromServer(urlString: data.courseimg!)
            coursename.text = data.coursename
            duration.text = "Duration : " + data.duration!
            batchdate.text = "Batchdate : " + data.batchdate!
            
            loutcome.text = data.learningoutcome
            
            cururl = data.curriculum!
            certurl = data.certificate!
            videourl = data.video!
            coursesurl = data.coursesurl!
            courseid = data.courseid!
            fees = data.fees!
            if(fees == "0")
            {
                freebtn.setTitle("FREE", for: .normal)
            }
           else
            {
                freebtn.setTitle(fees , for: .normal)
            }

            
        }
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.opencertificate))
                   self.certview.addGestureRecognizer(gesture)
        let gesture2 = UITapGestureRecognizer(target: self, action:  #selector(self.opencurriculum))
        self.curview.addGestureRecognizer(gesture2)
        let gesture3 = UITapGestureRecognizer(target: self, action:  #selector(self.openvideo))
        self.videoview.addGestureRecognizer(gesture3)
        
        self.partnercollectionview.delegate = self
        self.partnercollectionview.dataSource = self
        self.facultycollectionview.delegate = self
        self.facultycollectionview.dataSource = self
        registerTableViewcell()
        Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(scrollAutomatically(_:)), userInfo: nil, repeats: true)
    }
    func registerTableViewcell(){
              
           self.partnercollectionview.register(UINib(nibName: "CoursedetailCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CoursedetailCollectionViewCell")
                 self.facultycollectionview.register(UINib(nibName: "FacultyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FacultyCollectionViewCell")
              
              
          }
    
     //Collectionview
        
//        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//            if collectionView == self.partnercollectionview
//            {
//            return CGSize(width: 120.0 , height: 60.0)
//            }
//
//         }
    @objc func opencertificate(sender : UITapGestureRecognizer) {
             // Do what you want
        
        openwebview(url: certurl)
         }
    @objc func opencurriculum(sender : UITapGestureRecognizer) {
                // Do what you want
           
           openwebview(url: cururl)
            }
    @objc func openvideo(sender : UITapGestureRecognizer) {
                // Do what you want
           
           openwebview(url: videourl)
            }
         
    func openwebview(url:String)
    {
        guard let url = URL(string: url) else {
          return //be safe
        }

        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
         func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            if collectionView == self.partnercollectionview
                      {
            return partnerslogodata.count
            }
            else
            {
                 return facultydata.count
            }
         }
         
         func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            if collectionView == self.facultycollectionview
            {
                let cell:FacultyCollectionViewCell = facultycollectionview.dequeueReusableCell(withReuseIdentifier: "facultycell", for: indexPath) as! FacultyCollectionViewCell
                            
                           let data = facultydata[indexPath.item]
                if data.fimg!.isEmpty
                {
                    cell.fimage.image = UIImage.init(named: "user")
                    
                }
                else{
                cell.fimage.imageFromServer(urlString: data.fimg ?? "")
                }
                                   cell.fname.text = data.fname
                                   cell.fdescr.text = data.fdesc
                   //
                     // cell.partnerimage.imageFromServer(urlString: data.pimg!)
                           return cell
                
            }
            else{
                let cell:CoursedetailCollectionViewCell = partnercollectionview.dequeueReusableCell(withReuseIdentifier: "partnerslogocell", for: indexPath) as! CoursedetailCollectionViewCell
                         
                        let data = partnerslogodata[indexPath.item]
                        
                //
                 cell.partnerimage.imageFromServer(urlString: data.pimg!)
                        return cell
            }
         }
             
         @objc func scrollAutomatically(_ timer1: Timer) {
             if let temporaryView  = partnercollectionview {
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
         
         @IBAction func interested_action(_sender : UIButton)
         {
            performSegue(withIdentifier: "applydetails", sender: _sender)
    }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          // Get the new view controller using segue.destination.
          // Pass the selected object to the new view controller.
              
                  
           if segue.identifier == "applydetails" {
             let vc = segue.destination as! InterestedformTableViewController
                
            vc.courseid = courseid
            vc.fees = fees
            vc.coursesurl = coursesurl
             // vc.grandtotal.text = "Grand total :" + String(gtotal)


                  }
    }
    
 
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 7
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        /*
         1-307
         2-118
         3-259
         4-123
         5-104
         6-168
         7- 168
         */
         
        if indexPath.row == 0
        {
            return 307.0
        }
        else  if indexPath.row == 1
               {
                   return 118.0
               }
        else  if indexPath.row == 2
               {
                   return 259.0
               }
        else  if indexPath.row == 3
               {
                   return 123.0
               }
        else  if indexPath.row == 4
               {
                   return 104.0
               }
        else  if indexPath.row == 5
               {
                   if self.partnerslogodata.count > 0
                   {
                       return 168.0
                   }
                   else
                   {
                           return 0
                       }
               }
        else  if indexPath.row == 6
               {
                   return 168.0
               }
       
        else{
        
                return UITableView.automaticDimension
        }
            }
    
//     func tableView(_ tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        var cell = super.tableView(tableView, cellForRowAtIndexPath: indexPath)
//
//        if cell == self.cellYouWantToHide {
//            return 0
//        }
//
//        return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
//    }
}
extension CourseDetailsTableViewController: UICollectionViewDelegateFlowLayout {
         func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
             return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
         }
         
         func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
             let size = collectionView.frame.size
             return CGSize(width: size.width, height: size.height)
         }
         
         func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
             return 0.0
         }
         
         func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
             return 0.0
         }
 }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

