//
//  AllWebinarTableViewCell.swift
//  Amity
//
//  Created by Vinayak Tudayekar on 28/06/20.
//  Copyright © 2020 Eneblur Consulting. All rights reserved.
//

import UIKit

class AllWebinarTableViewCell: UITableViewCell, UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    @IBOutlet weak var allWebinorCollectionView: UICollectionView!
    @IBOutlet weak var allWebinorPageOutlet: UIPageControl!
 
    var section2Images = ["screen1","screen2","screen3","screen4","screen5"]
    
    var sectionLabel: String = ""
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.allWebinorCollectionView.register(UINib(nibName: "AllWebinorCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AllWebinorCollectionViewCell")
        allWebinorCollectionView.delegate = self
        allWebinorCollectionView.dataSource = self
        allWebinorPageOutlet.currentPageIndicatorTintColor = UIColor(named: "DarkBlueColour")
        allWebinorPageOutlet.pageIndicatorTintColor = UIColor(named: "DarkYellowColour")
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
                return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
            
       
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section2Images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AllWebinorCollectionViewCell", for: indexPath) as! AllWebinorCollectionViewCell
        
        
         cell.allWebinorImage.image = UIImage(named : section2Images[indexPath.item])
        
        return cell
    }
   
}
extension AllWebinarTableViewCell : UIPageViewControllerDelegate{
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.allWebinorPageOutlet.currentPage = indexPath.item
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.allWebinorPageOutlet.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
}

