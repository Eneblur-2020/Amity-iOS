//
//  MyProfileDetailTableViewCell.swift
//  Amity
//
//  Created by Vinayak Tudayekar on 04/07/20.
//  Copyright © 2020 Eneblur Consulting. All rights reserved.
//

import UIKit

class MyProfileDetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var myProfileTitle: UILabel!
    @IBOutlet weak var myProfileDescrption: UILabel!
    @IBOutlet weak var addButon: UIButton!
    @IBOutlet weak var profileSummaryView:UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cardViewSetUp()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func cardViewSetUp(){
        profileSummaryView.layer.cornerRadius = 2
        profileSummaryView.layer.shadowRadius = 2
        profileSummaryView.layer.shadowOpacity = 1.0
        profileSummaryView.layer.shadowColor = UIColor.gray.cgColor
        profileSummaryView.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
    }
    
}
