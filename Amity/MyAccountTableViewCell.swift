//
//  MyAccountTableViewCell.swift
//  Amity
//
//  Created by Vinayak Tudayekar on 01/07/20.
//  Copyright © 2020 Eneblur Consulting. All rights reserved.
//

import UIKit

class MyAccountTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell(){
        
    }
    
}
