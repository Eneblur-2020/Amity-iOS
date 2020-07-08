//
//  ExperienceCardTableViewCell.swift
//  Amity
//
//  Created by Vinayak Tudayekar on 03/07/20.
//  Copyright © 2020 Eneblur Consulting. All rights reserved.
//

import UIKit

class ExperienceCardTableViewCell: UITableViewCell {
    

    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var jobTitleLabel: UILabel!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var experienceView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cardViewSetUp()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func cardViewSetUp(){
        experienceView.layer.cornerRadius = 2
        experienceView.layer.shadowRadius = 2
        experienceView.layer.shadowOpacity = 1.0
        experienceView.layer.shadowColor = UIColor.gray.cgColor
        experienceView.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
    }
    
}
