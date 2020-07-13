//
//  GalleryTableViewCell.swift
//  Amity
//
//  Created by Vinayak Tudayekar on 05/07/20.
//  Copyright © 2020 Eneblur Consulting. All rights reserved.
//

import UIKit
class GalleryTableViewCell: UITableViewCell, UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var galleryCollectionView: UICollectionView!
    
    @IBOutlet weak var galleryCollectionViewHeightLayout: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        initialSetUp()
        apiCall()
       
    }
    func initialSetUp(){
        self.galleryCollectionView.register(UINib(nibName: "GalleryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "GalleryCollectionViewCell")
        galleryCollectionView.delegate = self
        galleryCollectionView.dataSource = self
        
        if let layout = galleryCollectionView?.collectionViewLayout as? UICollectionViewFlowLayout{
                layout.minimumLineSpacing = 10
                layout.minimumInteritemSpacing = 10
                layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
            let size = CGSize(width:(galleryCollectionView!.bounds.width)/2, height: (galleryCollectionView!.bounds.height)/1.5)
                layout.itemSize = size
        }
        
    }
    func apiCall(){
       ApiUtil.apiUtil.galleryAPI{ (result) in
            self.galleryCollectionView.reloadData()
        
        }
        
       
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
         let galleyType = imageArray[indexPath.row]
        if galleyType.type == "IMAGE" {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryCollectionViewCell", for: indexPath) as! GalleryCollectionViewCell
       //  cell.collectionViewHeight.constant = cell.collectionView.collectionViewLayout.collectionViewContentSize.height
        cell.setUpCell(gallery: imageArray[indexPath.row])
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
