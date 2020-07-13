//
//  AllEventsTableViewCell.swift
//  Amity
//
//  Created by Vinayak Tudayekar on 05/07/20.
//  Copyright © 2020 Eneblur Consulting. All rights reserved.
//

import UIKit

class AllEventsTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    
    @IBOutlet weak var allEventsCollectionView: UICollectionView!
    @IBOutlet weak var allEventsPageOutlet: UIPageControl!
    weak var eventDelegate: EventsCollectionViewDelegate? = nil
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        initialSetUp()
        apiCall()
    }
    func initialSetUp(){
        self.allEventsCollectionView.register(UINib(nibName: "AllEventsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AllEventsCollectionViewCell")
        allEventsCollectionView.delegate = self
        allEventsCollectionView.dataSource = self
        allEventsPageOutlet.currentPageIndicatorTintColor = UIColor(named: "DarkBlueColour")
        allEventsPageOutlet.pageIndicatorTintColor = UIColor(named: "DarkYellowColour")
    }
    func apiCall(){
        ApiUtil.apiUtil.eventAPI { (result) in
            self.allEventsCollectionView.reloadData()
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width:collectionView.frame.width/2,height:collectionView.frame.height)
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return eventArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AllEventsCollectionViewCell", for: indexPath) as! AllEventsCollectionViewCell
        
        cell.setUpCell(event: eventArray[indexPath.row])
        //cell.allEventsImage.image = UIImage(named : section3Images[indexPath.item])
        return cell
    }
    
    
}
extension AllEventsTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if eventDelegate != nil {
            eventDelegate?.onClickEventsCollectionCell(data: eventArray[indexPath.row], indexPath: indexPath,isFrom:EVENT)
        }
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


