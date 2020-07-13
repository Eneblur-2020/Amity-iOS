//
//  VideoCollectionViewCell.swift
//  Amity
//
//  Created by Vinayak Tudayekar on 10/07/20.
//  Copyright © 2020 Eneblur Consulting. All rights reserved.
//

import UIKit

class VideoCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var galleryImage: UIImageView!
    @IBOutlet weak var imageTitleLabel:UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setUpCell(gallery: Gallery){
           self.imageTitleLabel.text = "4"
           
       }
}
