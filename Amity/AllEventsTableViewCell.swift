//
//  AllEventsTableViewCell.swift
//  Amity
//
//  Created by Vinayak Tudayekar on 05/07/20.
//  Copyright © 2020 Eneblur Consulting. All rights reserved.
//

import UIKit

class AllEventsTableViewCell: UITableViewCell, UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    
    @IBOutlet weak var allEventsCollectionView: UICollectionView!
    @IBOutlet weak var allEventsPageOutlet: UIPageControl!
    
    var section3Images = ["screen1","screen2","screen3","screen4","screen5"]
    var section3Label = ["sula fest","Zotalabs event","Fest","Oddesy","cinfra"]
    
    var sectionLabel: String = ""
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.allEventsCollectionView.register(UINib(nibName: "AllEventsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AllEventsCollectionViewCell")
        allEventsCollectionView.delegate = self
        allEventsCollectionView.dataSource = self
        allEventsPageOutlet.currentPageIndicatorTintColor = UIColor(named: "DarkBlueColour")
        allEventsPageOutlet.pageIndicatorTintColor = UIColor(named: "DarkYellowColour")
    }
    func configureCell() {
        allEventsCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        return CGSize(width:collectionView.frame.width/2,height:collectionView.frame.height)
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section3Images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AllEventsCollectionViewCell", for: indexPath) as! AllEventsCollectionViewCell
        
        
        cell.allEventsImage.image = UIImage(named : section3Images[indexPath.item])
        cell.alleventsLabel.text = section3Label[indexPath.item]
        
        
        return cell
    }
    
    
}
extension AllEventsTableViewCell : UIPageViewControllerDelegate{
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.allEventsPageOutlet.currentPage = indexPath.item
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.allEventsPageOutlet.currentPage = Int(scrollView.contentOffset.x) / (Int(scrollView.frame.width)/2)
    }
}


