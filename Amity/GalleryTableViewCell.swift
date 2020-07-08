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
    
   var section3Images = ["screen1","screen2","screen3","screen4","screen5"]
        
        var sectionLabel: String = ""
        override func awakeFromNib() {
            super.awakeFromNib()
            // Initialization code
            self.galleryCollectionView.register(UINib(nibName: "GalleryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "GalleryCollectionViewCell")
            galleryCollectionView.delegate = self
            galleryCollectionView.dataSource = self
            
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
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryCollectionViewCell", for: indexPath) as! GalleryCollectionViewCell
            
            cell.galleryImage.image = UIImage(named : section3Images[indexPath.item])
            
            
            return cell
        }
        
        
    }
    


