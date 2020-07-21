//
//  SliderTableViewCell.swift
//  Amity
//
//  Created by Vinayak Tudayekar on 27/06/20.
//  Copyright © 2020 Eneblur Consulting. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher
import ANActivityIndicator

class SliderTableViewCell: UITableViewCell {
    @IBOutlet weak var sliderCollectionView: UICollectionView!
    @IBOutlet weak var pageOutlet: UIPageControl!
    var timer : Timer!
    let activity : ANActivityIndicatorView? = nil
    weak var delegate:TableViewInsideCollectionViewDelegate? = nil
    weak var activityIndicatorDelegate: ActivityIndicatorDelegate? = nil
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initialSetUp()
        // Initialization code
    }
    override func layoutSubviews() {
        
         apiCall()
    }
    func initialSetUp(){
        self.sliderCollectionView.register(UINib(nibName: "SliderCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SliderCollectionViewCell")
        self.sliderCollectionView.delegate = self
        self.sliderCollectionView.dataSource = self
        pageOutlet.currentPageIndicatorTintColor = UIColor(named: "DarkBlueColour")
        pageOutlet.pageIndicatorTintColor = UIColor(named: "DarkYellowColour")
        // Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(scrollAutomatically(_:)), userInfo: nil, repeats: true)
    }
    func apiCall(){
        //webinarAPI(url: WEBINAR_API)
        
        ApiUtil.apiUtil.webinarAPI { (result) in
            self.sliderCollectionView.reloadData()
            self.activityIndicatorDelegate?.activityIndicatorOnHomePage()
            
        }
        ApiUtil.apiUtil.webinarUpcomingAPI{ (result) in
            
        }
    }
    func webinarAPI(url:String){
        
        if isInternetAvailable(){
            Util.Manager.request(url, method : .get, encoding: JSONEncoding.default).responseJSON { (response) in
                switch response.result{
                case .success(_):
                    if let json = response.result.value{
                        if let jsonData = json as? NSDictionary {
                            if let status = jsonData.object(forKey: "status") as? Int {
                                if status == 200{
                                    if let data = jsonData.object(forKey: "data") as? [NSDictionary]{
                                        self.parseWebinorData(webinorData: data)
                                    }
                                }
                            }
                        }
                    }
                    break
                case .failure(_):
                    if (response.response?.statusCode) != nil {
                        
                    }
                    break
                    
                }
            }
        } else {
            //Util.showWhistle(message: NO_INTERNET, viewController: self)
        }
        
    }
    func parseWebinorData(webinorData:[NSDictionary]){
        webinorArray.removeAll()
        for webinor in webinorData{
            let webinorInfo = Webinor()
            if let instructorImage =  webinor.object(forKey: "instructorImage") as? NSDictionary{
                webinorInfo.instructorImage = instructorImage
            }
            if let webinarImage =  webinor.object(forKey: "webinarImage") as? NSDictionary{
                webinorInfo.webinarImage = webinarImage
            }
            if let isActive =  webinor.object(forKey: "isActive") as? Bool{
                webinorInfo.isActive = isActive
            }
            if let id =  webinor.object(forKey: "_id") as? String{
                webinorInfo.id = id
            }
            if let webinarTitle =  webinor.object(forKey: "webinarTitle") as? String{
                webinorInfo.webinarTitle = webinarTitle
            }
            if let instructorName =  webinor.object(forKey: "instructorName") as? String{
                webinorInfo.instructorName = instructorName
            }
            if let instructorDetails =  webinor.object(forKey: "instructorDetails") as? String{
                webinorInfo.instructorDetails = instructorDetails
            }
            if let webinarDateTime =  webinor.object(forKey: "webinarDateTime") as? String{
                webinorInfo.webinarDateTime = webinarDateTime
            }
            if let webinarDetails =  webinor.object(forKey: "webinarDetails") as? String{
                webinorInfo.webinarDetails = webinarDetails
            }
            if let webinarURL =  webinor.object(forKey: "webinarURL") as? String{
                webinorInfo.webinarURL = webinarURL
            }
            if let v =  webinor.object(forKey: "__v") as? Int {
                webinorInfo.v = v
            }
            if let createdAt =  webinor.object(forKey: "createdAt") as? String{
                webinorInfo.createdAt = createdAt
            }
            if let updatedAt =  webinor.object(forKey: "updatedAt") as? String{
                webinorInfo.updatedAt = updatedAt
            }
            webinorArray.append(webinorInfo)
            self.sliderCollectionView.reloadData()
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
    
    
    
    @objc func scrollAutomatically(_ timer1: Timer) {
        if let temporaryView  = sliderCollectionView {
            for cell in temporaryView.visibleCells {
                let indexPath: IndexPath? = temporaryView.indexPath(for: cell)
                if ((indexPath?.item)!  < webinorArray.count - 1){
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

extension SliderTableViewCell:UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: sliderCollectionView.frame.width , height: sliderCollectionView.frame.height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return webinorArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SliderCollectionViewCell", for: indexPath) as! SliderCollectionViewCell
        // cell.sliderImage.image = UIImage(named : arrayOfImages[indexPath.item])
        cell.registerButton.addTarget(self, action: #selector(onRegisterButtonClick), for: .touchUpInside)
        cell.registerButton.tag = indexPath.row
        cell.setUpCell(webinor: webinorArray[indexPath.row])
        return cell
    }
    @objc func onRegisterButtonClick(sender: UIButton){
        let indexpath = IndexPath(row: sender.tag, section: 0)
        if delegate != nil {
            delegate?.onClickWebinarSlider(data: webinorArray[indexpath.row],indexPath:indexpath,isFrom:WEBINAR)
        }
    }
}
extension SliderTableViewCell:UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if delegate != nil {
            delegate?.onClickWebinarSlider(data: webinorArray[indexPath.row],indexPath:indexPath,isFrom:WEBINAR)
        }
       
    }
}

extension SliderTableViewCell : UIPageViewControllerDelegate{
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.pageOutlet.currentPage = indexPath.item
        self.pageOutlet.numberOfPages = webinorArray.count
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageOutlet.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
}
