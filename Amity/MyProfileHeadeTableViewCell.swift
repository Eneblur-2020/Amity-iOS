//
//  MyProfileHeadeTableViewCell.swift
//  Amity
//
//  Created by Vinayak Tudayekar on 06/07/20.
//  Copyright © 2020 Eneblur Consulting. All rights reserved.
//

import UIKit

class MyProfileHeadeTableViewCell: UITableViewCell {
    @IBOutlet weak var headerName: UILabel!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var headerView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
