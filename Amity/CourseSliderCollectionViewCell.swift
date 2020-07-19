//
//  CourseSliderCollectionViewCell.swift
//  Amity
//
//  Created by Snehalatha Desai on 10/07/20.
//  Copyright © 2020 Eneblur Consulting. All rights reserved.
//

import UIKit

class CourseSliderCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var coursesliderImage: UIImageView!
    @IBOutlet weak var coursename: UILabel!
    @IBOutlet weak var facultyname: UILabel!
    @IBOutlet weak var duration: UILabel!
    @IBOutlet weak var registerbtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
