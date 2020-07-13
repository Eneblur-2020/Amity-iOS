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
    func setUpCell(expData:MyExperince){
        
            self.companyLabel.isHidden = false
            self.fromDateLabel.isHidden = false
            self.editButton.isHidden = false
            self.jobTitleLabel.text = expData.jobTitle
            self.companyLabel.text = expData.company
            self.fromDateLabel.text = (expData.startDate ?? "") + " To " + (expData.endDate ?? "")
        
    }
    func setUpCellForNoData(){
        self.companyLabel.isHidden = true
        self.fromDateLabel.isHidden = true
        self.editButton.isHidden = true
    }
    
    func cardViewSetUp(){
        expCardView.layer.cornerRadius = 2
        expCardView.layer.shadowRadius = 2
        expCardView.layer.shadowOpacity = 1.0
        expCardView.layer.shadowColor = UIColor.gray.cgColor
        expCardView.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
    }
}
