//
//  CoursedetailTableViewCell.swift
//  Amity
//
//  Created by Snehalatha Desai on 16/07/20.
//  Copyright © 2020 Eneblur Consulting. All rights reserved.
//

import UIKit

class CoursedetailTableViewCell: UITableViewCell {

    @IBOutlet weak var fimage: UIImageView!
       @IBOutlet weak var fname: UILabel!
     
       @IBOutlet weak var fdescr: UILabel!
      
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
