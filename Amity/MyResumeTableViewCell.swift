//
//  MyResumeTableViewCell.swift
//  Amity
//
//  Created by Vinayak Tudayekar on 04/07/20.
//  Copyright © 2020 Eneblur Consulting. All rights reserved.
//

import UIKit

class MyResumeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var myProfileTitle: UILabel!
    @IBOutlet weak var myProfileDescrption: UILabel!
    @IBOutlet weak var addButon: UIButton!
    @IBOutlet weak var myResumeView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        cardViewSetUp()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func cardViewSetUp(){
        myResumeView.layer.cornerRadius = 2
        myResumeView.layer.shadowRadius = 2
        myResumeView.layer.shadowOpacity = 1.0
        myResumeView.layer.shadowColor = UIColor.gray.cgColor
        myResumeView.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
    }
    
}
