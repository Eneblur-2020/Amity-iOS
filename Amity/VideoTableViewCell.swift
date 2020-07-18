//
//  VideoTableViewCell.swift
//  Amity
//
//  Created by Vinayak Tudayekar on 17/07/20.
//  Copyright © 2020 Eneblur Consulting. All rights reserved.
//

import UIKit

class VideoTableViewCell: UITableViewCell {
    @IBOutlet weak var videoImage: UIImageView!
    @IBOutlet weak var viewAllButton:UIButton!
    @IBOutlet weak var videoCountLabel:UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
