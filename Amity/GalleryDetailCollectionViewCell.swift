//
//  GalleryDetailCollectionViewCell.swift
//  Amity
//
//  Created by Vinayak Tudayekar on 13/07/20.
//  Copyright © 2020 Eneblur Consulting. All rights reserved.
//

import UIKit

class GalleryDetailCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var galleryImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setUpCell(gallery: Gallery){
        if let url = URL(string: gallery.image?.value(forKey: "url") as? String ?? "") {
            self.galleryImage.kf.setImage(with: url, placeholder: UIImage(named: ""))
        }
    }
}
