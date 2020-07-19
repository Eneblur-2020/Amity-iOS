//
//  TestiCollectionViewCell.swift
//  Amity
//
//  Created by Snehalatha Desai on 11/07/20.
//  Copyright © 2020 Eneblur Consulting. All rights reserved.
//

import UIKit

class TestiCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var profilepic: UIImageView!
       @IBOutlet weak var studname: UILabel!
       @IBOutlet weak var descr: UITextView!
       
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
