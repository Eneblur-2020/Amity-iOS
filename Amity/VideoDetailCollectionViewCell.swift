//
//  VideoDetailCollectionViewCell.swift
//  Amity
//
//  Created by Vinayak Tudayekar on 16/07/20.
//  Copyright © 2020 Eneblur Consulting. All rights reserved.
//

import UIKit
import Kingfisher

class VideoDetailCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var videoImage: UIImageView!
    @IBOutlet weak var videoLabel: UILabel!
    override func awakeFromNib() {
           super.awakeFromNib()
           // Initialization code
       }
       func setUpCell(gallery: Gallery){
           if let url = URL(string: gallery.image?.value(forKey: "url") as? String ?? "") {
               self.videoImage.kf.setImage(with: url, placeholder: UIImage(named: ""))
           }
        videoLabel.text = gallery.videoTitle
       }
}
