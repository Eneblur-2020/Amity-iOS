//
//  GalleryCollectionViewCell.swift
//  Amity
//
//  Created by Vinayak Tudayekar on 05/07/20.
//  Copyright © 2020 Eneblur Consulting. All rights reserved.
//

import UIKit

class GalleryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var galleryImage: UIImageView!
    @IBOutlet weak var imageTitleLabel:UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setUpCell(gallery: Gallery){
        self.imageTitleLabel.text = gallery.imageTitle
        if let url = URL(string: gallery.image?.value(forKey: "url") as? String ?? "") {
            self.galleryImage.kf.setImage(with: url, placeholder: UIImage(named: "screen4.png"))
        }
    }


}
