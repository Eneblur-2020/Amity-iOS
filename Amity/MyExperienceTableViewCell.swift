//
//  MyExperienceTableViewCell.swift
//  Amity
//
//  Created by Vinayak Tudayekar on 04/07/20.
//  Copyright © 2020 Eneblur Consulting. All rights reserved.
//

import UIKit

class MyExperienceTableViewCell: UITableViewCell {
    
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var jobTitleLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var fromDateLabel: UILabel!
    @IBOutlet weak var toDateLabel: UILabel!
    @IBOutlet weak var expCardView:UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        cardViewSetUp()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func cardViewSetUp(){
        expCardView.layer.cornerRadius = 2
        expCardView.layer.shadowRadius = 2
        expCardView.layer.shadowOpacity = 1.0
        expCardView.layer.shadowColor = UIColor.gray.cgColor
        expCardView.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
    }
}
