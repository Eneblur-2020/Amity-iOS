//
//  TestiCollectionViewCell.swift
//  Amity
//
//  Created by Snehalatha Desai on 19/07/20.
//  Copyright © 2020 Eneblur Consulting. All rights reserved.
//

import UIKit

class TestiCollectionViewCell: UICollectionViewCell {
 @IBOutlet weak var studview: UIView!
    @IBOutlet weak var profilepic: UIImageView!
       @IBOutlet weak var studname: UILabel!
       @IBOutlet weak var descr: UITextView!
       
    override func awakeFromNib() {
        super.awakeFromNib()
        initWithNib()
        // Initialization code
    }
    func initWithNib() {
        studview.layer.shadowColor = UIColor.lightGray.cgColor
        studview.layer.shadowOpacity = 1.0
          studview.layer.shadowOffset = .zero
        studview.layer.shadowRadius = 4.0
        studview.layer.borderWidth = 1.0
        studview.layer.borderColor = UIColor.darkGray.cgColor
          studview.layer.cornerRadius = 2
          
          
      }
}
