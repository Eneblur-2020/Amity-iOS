//
//  HomePageViewController.swift
//  
//
//  Created by swapna raddi on 03/06/20.
//

import UIKit

class HomePageViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageView: UIPageControl!
    @IBOutlet weak var webinarCollectionView: UICollectionView!
    @IBOutlet weak var webinarPageView: UIPageControl!
    
    @IBOutlet weak var titleName: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var participants: UILabel!

    
        var imgArr = [ UIImage(named: "screen1"), UIImage(named: "screen2")
        ,UIImage(named: "screen3"), UIImage(named: "screen4")]
        
        var timer = Timer()
        var counter = 0
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
        
            getUpcommingWebinars()
            
            for view in self.titleName.subviews as [UIView] {
                if let labelReference = view as? UILabel{
                    labelReference.text = title
                   
                }
            }
            
            
            pageView.numberOfPages = imgArr.count
            pageView.currentPage = 0
            DispatchQueue.main.async {
                self.timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
            }
            
            //Webinar Image page control
            timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(changeImage), userInfo: nil, repeats: true)
            webinarPageView.numberOfPages = imgArr.count
            webinarPageView.currentPage = 0
            
            //self.titleName.text = title
               
            DispatchQueue.main.async {
                self.timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.changeWebinarImage), userInfo: nil, repeats: true)
            }
        }
        
       //Featured Collection of ImageView
        @objc func changeImage(){
            if counter < imgArr.count {
                let index = IndexPath.init(item: counter, section: 0)
                self.collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
                pageView.currentPage = counter
                counter += 1
                //titleName.self.text = title.self
                
            } else {
                counter = 0
                let index = IndexPath.init(item: counter, section: 0)
                self.collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
                pageView.currentPage = counter
            }
        }
    
    //Register Button
    @IBAction func registerButtonPressed(_ sender: Any) {
        
    }
    

       //Webinar ImageView
        @objc func changeWebinarImage(){
           if counter < imgArr.count {
               let index = IndexPath.init(item: counter, section: 0)
               self.webinarCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
               webinarPageView.currentPage = counter
               counter += 1
               
        
           } else {
               counter = 0
               let index = IndexPath.init(item: counter, section: 0)
               self.webinarCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
               webinarPageView.currentPage = counter
           }
       }
   }



    extension HomePageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return imgArr.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            
            if let vc = cell.viewWithTag(111) as? UIImageView {
                vc.image = imgArr[indexPath.row]
             
            }
            else if let ab = cell.viewWithTag(222) as? UIPageControl{
                ab.currentPage = indexPath.row
            }
            return cell
        }
    }

    extension HomePageViewController: UICollectionViewDelegateFlowLayout {
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

//get upcomming webinars
func getUpcommingWebinars(){
    
     let userUrl = "https://dev.backend.afawebapp.zotalabs.com/webinar"
              // Add one parameter
            let myUrl = NSURL(string: userUrl)
              
              // Creaste URL Request
            let request = NSMutableURLRequest(url:myUrl! as URL)
            request.httpMethod = "GET"
    
            let task = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
                           guard error == nil && data != nil else {      // check for fundamental networking error
                               print("error=\(String(describing: error))")
                               return
                           }
                do {
                    if let responseJSON = try JSONSerialization.jsonObject(with: data!) as? [String:AnyObject]{
                    //print(responseJSON)
                        
                        if let wdata = responseJSON["data"] as? [AnyObject]{
                            print(wdata)
                            for details in wdata{
                                
                                let title = details["webinarTitle"] as! String
                                print(title)

                                let wDate = details["webinarDateTime"] as! String
                                print(wDate)
                                print("------")
                                
                                
                            }
                        }
                        
                    
                    }
            }
                catch {
                    print("Error -> \(error)")
            }
 }
      task.resume()
}




