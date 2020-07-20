//
//  GalleryCollectionViewCell.swift
//  Amity
//
//  Created by Vinayak Tudayekar on 05/07/20.
//  Copyright © 2020 Eneblur Consulting. All rights reserved.
//

import UIKit
protocol GalleryCollectionViewDelegate:class {
    func onClickGalleryCollectionCell(data:Gallery,indexPath:IndexPath)
}
class GalleryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var galleryImage: UIImageView!
    @IBOutlet weak var imageTitleLabel:UILabel!
      @IBOutlet weak var imageNumofPhotosLabel:UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setUpCell(gallery: Gallery){
        self.imageTitleLabel.text = gallery.imageTitle
      let  images = imageArray.filter {
        $0.imageTitle == gallery.imageTitle!


                       }
        let str = String.init(format: "%d Photos", images.count)
        self.imageNumofPhotosLabel.text = str
        if let url = URL(string: gallery.image?.value(forKey: "url") as? String ?? "") {
            self.galleryImage.kf.setImage(with: url, placeholder: UIImage(named: ""))
        }
    }


}
