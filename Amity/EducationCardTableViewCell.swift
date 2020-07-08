//
//  EducationCardTableViewCell.swift
//  Amity
//
//  Created by Vinayak Tudayekar on 05/07/20.
//  Copyright © 2020 Eneblur Consulting. All rights reserved.
//

import UIKit

class EducationCardTableViewCell: UITableViewCell {
    
    @IBOutlet weak var degreeLabel: UILabel!
    @IBOutlet weak var school_CollegeLabel: UILabel!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var educationView: UIView!
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
        educationView.layer.cornerRadius = 2
        educationView.layer.shadowRadius = 2
        educationView.layer.shadowOpacity = 1.0
        educationView.layer.shadowColor = UIColor.gray.cgColor
        educationView.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
    }
}
