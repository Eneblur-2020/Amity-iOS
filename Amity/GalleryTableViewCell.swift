//
//  GalleryTableViewCell.swift
//  Amity
//
//  Created by Vinayak Tudayekar on 05/07/20.
//  Copyright © 2020 Eneblur Consulting. All rights reserved.
//

import UIKit

class GalleryTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var galleryCollectionView: UICollectionView!
    @IBOutlet weak var galleryCollectionViewHeightLayout: NSLayoutConstraint!
    weak var galleryDelegate: GalleryCollectionViewDelegate? = nil
     weak var activityIndicatorDelegate:ActivityIndicatorDelegate? = nil
    var imageGroups = [[Gallery]]()
    var imageGroupArray = [Gallery]()
    var imageSectionArray = [String]()
  // let imageArray = [Image]()
    
    ////
    var dataModel = [GalleryDaya]()
    var sections = [String]()
    var rowsPerSection = [[GalleryDaya]]()

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
        self.galleryCollectionView.register(UINib(nibName: "GalleryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "GalleryCollectionViewCell")
        galleryCollectionView.register(UINib(nibName: "GalleryHeaderCollectionViewCell", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "GalleryHeaderCollectionViewCell")
        galleryCollectionView.delegate = self
        galleryCollectionView.dataSource = self
        
        if let layout = galleryCollectionView?.collectionViewLayout as? UICollectionViewFlowLayout{
                layout.minimumLineSpacing = 10
                layout.minimumInteritemSpacing = 10
                layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
            let size = CGSize(width:(galleryCollectionView!.bounds.width)/2, height: (galleryCollectionView!.bounds.height)/1.5)
                layout.itemSize = size
           // layout.headerReferenceSize = CGSize(width: galleryCollectionView.frame.size.width, height: 40)
        }
        
    }
    func apiCall(){
    
       ApiUtil.apiUtil.galleryAPI{ (result) in
            self.galleryCollectionView.reloadData()
         self.activityIndicatorDelegate?.activityIndicatorOnHomePage()
//        var grouped = Dictionary(grouping: galleryArray.firstIndex(where: { (element: Gallery) in
//            return element.imageTitle
//        }))
//        print(grouped)
        
        
      // let groupedItems = Dictionary(grouping: galleryArray, by: {$0.imageTitle})
       // print(groupedItems.keys)
       
       
        self.imageGroups = Array(Dictionary(grouping:galleryArray){$0.imageTitle}.values)

       }
       
       
       
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return  imageArray.count
//    }
  
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       imageArray.count
    }
    /* func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
             var reusableview: UICollectionReusableView? = nil
        if kind == UICollectionView.elementKindSectionHeader {
            if let sectionHeader =
                galleryCollectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "GalleryHeaderCollectionViewCell", for: indexPath) as? GalleryHeaderCollectionViewCell{
            sectionHeader.headerLabel.text = "TRENDING"
                
                return sectionHeader
        }
        }
        return UICollectionReusableView()
         }
    */
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
         let galleyType = imageArray[indexPath.row]
        if galleyType.type == "IMAGE" {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryCollectionViewCell", for: indexPath) as! GalleryCollectionViewCell
       //  cell.collectionViewHeight.constant = cell.collectionView.collectionViewLayout.collectionViewContentSize.height
          //  cell.imageTitleLabel.text = self.imageGroupArray[indexPath.row][indexPath.section]
        cell.setUpCell(gallery: galleyType)
            return cell
        //cell.galleryImage.image = UIImage(named : section3Images[indexPath.item])
       // } else if galleyType.type == "VIDEO" {
//      let videoCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoCollectionViewCell", for: indexPath) as! VideoCollectionViewCell
//        videoCollectionViewCell.setUpCell(gallery: galleryArray[indexPath.row])
//        return videoCollectionViewCell
        }
       return UICollectionViewCell()
    }
    
    
}
extension GalleryTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if galleryDelegate != nil {
            galleryDelegate?.onClickGalleryCollectionCell(data: imageArray[indexPath.row], indexPath: indexPath)
        }
    }
   
}

class DynamicCollectionView: UICollectionView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if bounds.size != intrinsicContentSize {
            invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return self.contentSize
}
}
