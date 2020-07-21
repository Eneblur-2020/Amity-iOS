//
//  AllAlbumCollectionViewCell.swift
//  Amity
//
//  Created by Vinayak Tudayekar on 20/07/20.
//  Copyright © 2020 Eneblur Consulting. All rights reserved.
//

import UIKit

class AllAlbumCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var galleryImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setUpCell(gallery: Gallery){
        let images = imageArray.filter {
            $0.imageTitle == gallery.imageTitle!
        }
        if let url = URL(string: gallery.image?.value(forKey: "url") as? String ?? "") {
            self.galleryImage.kf.setImage(with: url, placeholder: UIImage(named: ""))
        }
    }
}
