//
//  MyEducationTableViewCell.swift
//  Amity
//
//  Created by Vinayak Tudayekar on 04/07/20.
//  Copyright © 2020 Eneblur Consulting. All rights reserved.
//

import UIKit

class MyEducationTableViewCell: UITableViewCell {

    @IBOutlet weak var degreeLabel: UILabel!
    @IBOutlet weak var school_CollegeLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var fromDateLabel: UILabel!
    @IBOutlet weak var toDateLabel: UILabel!
    @IBOutlet weak var educationCardView:UIView!
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
             educationCardView.layer.cornerRadius = 2
             educationCardView.layer.shadowRadius = 2
             educationCardView.layer.shadowOpacity = 1.0
             educationCardView.layer.shadowColor = UIColor.gray.cgColor
             educationCardView.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
         }
    func setUpCell(educationData:MyEducation){
           
               self.degreeLabel.isHidden = false
               self.fromDateLabel.isHidden = false
               self.editButton.isHidden = false
               self.degreeLabel.text = educationData.Degree
               self.school_CollegeLabel.text = educationData.College_School
               self.fromDateLabel.text = (educationData.startDate ?? "") + " To " + (educationData.endDate ?? "")
           
       }
       func setUpCellForNoData(){
           self.degreeLabel.isHidden = true
           self.fromDateLabel.isHidden = true
           self.editButton.isHidden = true
       }
    
}
