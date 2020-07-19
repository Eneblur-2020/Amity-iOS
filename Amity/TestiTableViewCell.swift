//
//  TestiTableViewCell.swift
//  Amity
//
//  Created by Snehalatha Desai on 11/07/20.
//  Copyright © 2020 Eneblur Consulting. All rights reserved.
//

import UIKit


extension UIImageView {
  public func maskCircle(anyImage: UIImage) {
    self.contentMode = .scaleToFill
    self.layer.cornerRadius = self.frame.height / 2
    self.layer.masksToBounds = false
    self.clipsToBounds = true

   // make square(* must to make circle),
   // resize(reduce the kilobyte) and
   // fix rotation.
   self.image = anyImage
  }
}
class TestiTableViewCell:
UITableViewCell,UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var testiCollectionViewCell: UICollectionView!
   

    
       //var timer : Timer!
    var arrayOfNames = ["Thangaraj Muruganantham","Ishvinder Singh","Siddharth Tiwari","Munjal Patel"]
     var arrayOfDesc = ["No words to appreciate the career assistance from Amity. Always reaching out best companies in the market and Keeping the alumni more engaging. I have always been thankful to career assistance team.",
                        "Innovative platform and access to abundance of material. Best part of studying with Amity was the ready response from faculty and support team. I had a great learning experience with Amity.",
                        "I got to learn a lot from the people and the Institute. The staff is really helpful. Good and helpful team with time to time one on one sessions.",
                        "Blockchain Technology & Management course is very exhaustive and easy to understand course that is helpful to even non-IT background people. This course has indeee helped me change my career path."]
    var arrayOfImages = [UIImage.init(named: "thangaraj"),UIImage.init(named: "ishvinder"),UIImage.init(named: "siddharth"),UIImage.init(named: "munjalpatel")]
   
  override func awakeFromNib() {
            super.awakeFromNib()
            self.testiCollectionViewCell.register(UINib(nibName: "TestiCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TestiCollectionViewCell")
            self.testiCollectionViewCell.delegate = self
            self.testiCollectionViewCell.dataSource = self
           
           Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(scrollAutomatically(_:)), userInfo: nil, repeats: true)
            // Initialization code
        }

        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)

            // Configure the view for the selected state
        }

       
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 322.0 , height:161.0)
        }
        
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return arrayOfNames.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TestiCollectionViewCell", for: indexPath) as! TestiCollectionViewCell
            cell.studname.text = arrayOfNames[indexPath.item]
         //   let image:UIImage = UIImage(named: "photo")!
            cell.profilepic.image = arrayOfImages[indexPath.item]
             cell.descr.text = arrayOfDesc[indexPath.item]
            return cell
        }
            
        @objc func scrollAutomatically(_ timer1: Timer) {
            if let temporaryView  = testiCollectionViewCell {
                for cell in temporaryView.visibleCells {
                    let indexPath: IndexPath? = temporaryView.indexPath(for: cell)
                    if ((indexPath?.item)!  < arrayOfNames.count - 1){
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

//    extension CourseSliderTableViewCell : UIPageViewControllerDelegate{
//
//        func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//            self.pageOutlet.currentPage = indexPath.item
//        }
//
//        func CourseSliderTableViewCell(_ scrollView: UIScrollView) {
//            pageOutlet.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
//        }
    

 // main class close

