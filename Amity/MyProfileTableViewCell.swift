//
//  MyProfileTableViewCell.swift
//  Amity
//
//  Created by Vinayak Tudayekar on 04/07/20.
//  Copyright © 2020 Eneblur Consulting. All rights reserved.
//

import UIKit

class MyProfileTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var userEmailIdTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField:UITextField!

    override func awakeFromNib() {
        super.awakeFromNib()
       
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
