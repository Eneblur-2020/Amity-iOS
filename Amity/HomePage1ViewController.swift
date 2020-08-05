//
//  HomePage1ViewController.swift
//  Amity
//
//  Created by Vinayak Tudayekar on 27/06/20.
//  Copyright © 2020 Eneblur Consulting. All rights reserved.
//

import UIKit
import Alamofire



class HomePage1ViewController: BaseViewController,UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var sections = ["","All Webinars","All Events","Gallery",""]
    var sectionLabel = ["","Preview Upcoming Webinars","Upcoming Events","Recent Photos and Videos",""]
    var sectionButtonArray = ["VIEW ALL","VIEW ALL",]
    var webinorArray = [Webinor]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.title = "Amity Future Academy"
        tableView.delegate = self
        tableView.dataSource = self
        registerTableViewcell()
        setNavigationItem()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        startActivityIndicator()
         ApiUtil.apiUtil.galleryAPI{ (result) in
            self.tableView.reloadData()
        }
        tableView.estimatedRowHeight = 85.0
        tableView.rowHeight = UITableView.automaticDimension
       DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 5) { [weak self] in
           self?.tableView.reloadData()
       }
    }
    override func viewDidAppear(_ animated: Bool) {
        // tableView.reloadData()
    }
    func registerTableViewcell(){
        self.tableView.register(UINib(nibName: "SliderTableViewCell", bundle: nil), forCellReuseIdentifier: "SliderTableViewCell")
        self.tableView.register(UINib(nibName: "AllWebinarTableViewCell", bundle: nil), forCellReuseIdentifier: "AllWebinarTableViewCell")
        self.tableView.register(UINib(nibName: "AllEventsTableViewCell", bundle: nil), forCellReuseIdentifier: "AllEventsTableViewCell")
        self.tableView.register(UINib(nibName: "GalleryTableViewCell", bundle: nil), forCellReuseIdentifier: "GalleryTableViewCell")
        self.tableView.register(UINib(nibName: "VideoTableViewCell", bundle: nil),forCellReuseIdentifier: "VideoTableViewCell")
        
        
    }
    func apiCall(){
        
        // webinarAPI(url: WEBINAR_API)
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
            Util.showWhistle(message: NO_INTERNET, viewController: self)
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
            self.tableView.reloadData()
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.white
        let label = UILabel()
        label.textColor = UIColor(named: "TitleBlackColour")
        label.frame = CGRect(x: 20, y: 10, width: 400, height: 40)
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.text = sections[section]
        
        let detailLabel = UILabel()
        detailLabel.textColor = UIColor(named: "GreyColour")
        detailLabel.frame = CGRect(x: 20, y: 40, width: 400, height: 40)
        detailLabel.numberOfLines = 0
        detailLabel.lineBreakMode = .byWordWrapping
        detailLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        detailLabel.text = sectionLabel[section]
        view.addSubview(label)
        view.addSubview(detailLabel)
        
        
        let button = UIButton(frame: CGRect(x: UIScreen.main.bounds.size.width - 140, y: 10, width: 120, height: 40))
        button.setTitle("VIEW ALL", for: .normal)
        button.cornerRadius = 10
        button.setTitleColor(UIColor(named: "DarkBlueColour"), for: .normal)
        button.tag = section
        button.addTarget(self, action: #selector(onClickViewAllButton), for: .touchUpInside)
        
        button.backgroundColor = UIColor(named: "ButtonYellowColour")
        view.addSubview(button)
        if section == 1 {
            if upComingWebinorArray.count == 0 {
                button.isHidden = true
            }
        }
        if section == 2 {
            if upComingEventArray.count == 0 {
                button.isHidden = true
                label.isHidden = true
                detailLabel.isHidden = true
                label.frame = CGRect(x: 20, y: 10, width: 400, height: 0)
                detailLabel.frame = CGRect(x: 20, y: 40, width: 400, height: 0)

            }
            
        }
        if section == 3 {
            button.isHidden = true
        }
        return view
    }
    @objc func onClickViewAllButton(sender: UIButton){
        if sender.tag == 1 || sender.tag == 2 {
            if let webinarCalenderViewController = self.storyboard?.instantiateViewController(withIdentifier: "WebinarCalenderViewController") as? WebinarCalenderViewController {
                //nextViewController.finacerId = idArray[indexPath.row]
                if sender.tag == 1 {
                    webinarCalenderViewController.isFrom = WEBINAR
                } else if sender.tag == 2 {
                    webinarCalenderViewController.isFrom = EVENT
                }
                webinarCalenderViewController.tag = sender.tag
                
                self.navigationController?.pushViewController(webinarCalenderViewController, animated: true)
            }
        }
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        //return UITableViewAutomaticDimension
        if indexPath.section == 0{
            return 320
        }
        if indexPath.section == 1{
            
                return 400
            
        }
        if indexPath.section == 2{
            if upComingEventArray.count == 0 {
                  return UITableView.automaticDimension
            }else {
                return 270
                
            }
        }
        if indexPath.section == 3{
            return UITableView.automaticDimension
        }
        if indexPath.section == 4{
            return UITableView.automaticDimension
        }
        else{
            return 400
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 || section == 4{
            return 0
        }else if section == 2 {
            if upComingEventArray.count == 0 {
                return 0
            } else {
                return 90
            }
        }
        else{
            return 90
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SliderTableViewCell") as! SliderTableViewCell
            cell.delegate = self
            cell.activityIndicatorDelegate = self
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier:"AllWebinarTableViewCell" ) as! AllWebinarTableViewCell
            cell.delegate = self
            cell.activityIndicatorDelegate = self
            cell.sectionHeaderDelegate = self
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier:"AllEventsTableViewCell" ) as! AllEventsTableViewCell
            
            cell.eventDelegate = self
            cell.activityIndicatorDelegate = self
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier:"GalleryTableViewCell" ) as! GalleryTableViewCell
            cell.galleryDelegate = self
            cell.activityIndicatorDelegate = self
             cell.tableDataDelegate = self
            var height = cell.galleryCollectionView.collectionViewLayout.collectionViewContentSize.height
            cell.galleryCollectionViewHeightLayout.constant = height
            self.view.layoutIfNeeded()
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier:"VideoTableViewCell" ) as! VideoTableViewCell
            cell.videoCountLabel.text = "\(videoArray.count)" + "Videos"
            cell.viewAllButton.tag = indexPath.row
            cell.viewAllButton.addTarget(self, action: #selector(onClickGalleryViewAllButton), for: .touchUpInside)
            return cell
        default:
            print("do nothing")
        }
        
        return UITableViewCell()
        
    }
    @objc func onClickGalleryViewAllButton(sender:UIButton){
        let indexPath = IndexPath(row: sender.tag, section: 4)
        if let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "AllAlbumViewController") as? AllAlbumViewController {
            nextViewController.allalbumData = galleryArray[indexPath.row]
            
            self.navigationController?.pushViewController(nextViewController, animated: true)
        }
    }
}
extension HomePage1ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 4{
            if let videoDetailViewController = Storyboard.Main.instance.instantiateViewController(withIdentifier: "VideoDetailViewController") as? VideoDetailViewController {
                self.navigationController?.pushViewController(videoDetailViewController, animated: true)
                
            }
        }
    }
   
}
extension HomePage1ViewController :  TableViewInsideCollectionViewDelegate,EventsCollectionViewDelegate,GalleryCollectionViewDelegate,ActivityIndicatorDelegate,HideSectionHeaderDelegate,ReloadTableDataDelegate{
   
    
    
    func onClickWebinarSlider(data: Webinor,indexPath:IndexPath,isFrom:String) {
        if let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "WebinorDetailViewController") as? WebinorDetailViewController {
            //nextViewController.finacerId = idArray[indexPath.row]
            nextViewController.webinarData = data
            nextViewController.isFrom = isFrom
            self.navigationController?.pushViewController(nextViewController, animated: true)
        }
    }
    func onClickEventsCollectionCell(data: Event, indexPath: IndexPath,isFrom:String) {
        if let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "WebinorDetailViewController") as? WebinorDetailViewController {
            //nextViewController.finacerId = idArray[indexPath.row]
            nextViewController.eventsData = data
            nextViewController.isFrom = isFrom
            self.navigationController?.pushViewController(nextViewController, animated: true)
        }
    }
    func onClickGalleryCollectionCell(data: Gallery, indexPath: IndexPath) {
        if let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "GalleryDetailViewController") as? GalleryDetailViewController {
            //nextViewController.finacerId = idArray[indexPath.row]
            //nextViewController.eventsData = data
            //nextViewController.isFrom = isFrom
            // let data = imageArray[indexPath.row]
            imageArray = imageArray.filter {
                $0.imageTitle == data.imageTitle
                
                
            }
            nextViewController.pageTitle = imageArray[0].imageTitle ?? ""
            self.navigationController?.pushViewController(nextViewController, animated: true)
        }
    }
    
    func activityIndicatorOnHomePage(){
       // self.tableView.reloadData()
        self.stopActivityIndicator()
    }
    func hideSectionHeaderData() {
        self.tableView(tableView, viewForHeaderInSection: 1)
       // tableView.beginUpdates()
       // tableView.endUpdates()
       }
    func reloadTableData(){
        self.tableView.reloadData()
        //tableView.beginUpdates()
           //    tableView.endUpdates()
    }
       
}

