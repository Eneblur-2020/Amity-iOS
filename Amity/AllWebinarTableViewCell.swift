//
//  AllWebinarTableViewCell.swift
//  Amity
//
//  Created by Vinayak Tudayekar on 28/06/20.
//  Copyright © 2020 Eneblur Consulting. All rights reserved.
//

import UIKit
import ANActivityIndicator

class AllWebinarTableViewCell: UITableViewCell, UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    @IBOutlet weak var allWebinorCollectionView: UICollectionView!
    @IBOutlet weak var allWebinorPageOutlet: UIPageControl!
    weak var delegate:TableViewInsideCollectionViewDelegate? = nil
    weak var activityIndicatorDelegate:ActivityIndicatorDelegate? = nil
    var sectionLabel: String = ""
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        initialSetUp()
        apiCall()
    }
    override func layoutSubviews() {
            apiCall()
       }
    func initialSetUp(){
       self.allWebinorCollectionView.register(UINib(nibName: "AllWebinorCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AllWebinorCollectionViewCell")
        allWebinorCollectionView.delegate = self
        allWebinorCollectionView.dataSource = self
      
        allWebinorPageOutlet.currentPageIndicatorTintColor = UIColor(named: "DarkBlueColour")
        allWebinorPageOutlet.pageIndicatorTintColor = UIColor(named: "DarkYellowColour")
    }
    func apiCall(){
      
      /*          ApiUtil.apiUtil.webinarAPI { (result) in
            self.allWebinorCollectionView.reloadData()
                    self.activityIndicatorDelegate?.activityIndicatorOnHomePage()
        }
 */
        ApiUtil.apiUtil.webinarUpcomingAPI { (result) in
        self.allWebinorCollectionView.reloadData()
                self.activityIndicatorDelegate?.activityIndicatorOnHomePage()
        }
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
                return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
            
       
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return upComingWebinorArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AllWebinorCollectionViewCell", for: indexPath) as! AllWebinorCollectionViewCell
        
          cell.registerButton.addTarget(self, action: #selector(onRegisterButtonClick), for: .touchUpInside)
        cell.registerButton.tag = indexPath.row
        cell.setUpCell(webinor: upComingWebinorArray[indexPath.row])
         //cell.allWebinorImage.image = UIImage(named : section2Images[indexPath.item])
        
        return cell
    }
   
    @objc func onRegisterButtonClick(_ sender:UIButton){
        let indexpath = IndexPath(row: sender.tag, section: 0)
        if delegate != nil {
            delegate?.onClickWebinarSlider(data: upComingWebinorArray[indexpath.row],indexPath:indexpath,isFrom:WEBINAR)
        }
    }
}
extension AllWebinarTableViewCell: UITableViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SliderCollectionViewCell", for: indexPath) as! SliderCollectionViewCell
        if delegate != nil {
            delegate?.onClickWebinarSlider(data: upComingWebinorArray[indexPath.row],indexPath:indexPath,isFrom:WEBINAR)
        }
       // cell.delegate?.cellTaped(data: indexPath)
    }
}
extension AllWebinarTableViewCell : UIPageViewControllerDelegate{
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.allWebinorPageOutlet.currentPage = indexPath.section
        self.allWebinorPageOutlet.numberOfPages = upComingWebinorArray.count
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.allWebinorPageOutlet.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
}

