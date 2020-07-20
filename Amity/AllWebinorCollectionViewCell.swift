//
//  AllWebinorCollectionViewCell.swift
//  Amity
//
//  Created by Vinayak Tudayekar on 28/06/20.
//  Copyright © 2020 Eneblur Consulting. All rights reserved.
//

import UIKit

class AllWebinorCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var allWebinorView: UIView!
    @IBOutlet weak var allWebinorImage: UIImageView!
    @IBOutlet weak var webinorTitleLabel: UILabel!
    @IBOutlet weak var participantsLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var registerButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initWithNib()
        // Initialization code
    }
    
    func initWithNib() {
        allWebinorView.layer.shadowColor = UIColor.black.cgColor
        allWebinorView.layer.shadowOpacity = 1
        allWebinorView.layer.shadowOffset = .zero
        allWebinorView.layer.shadowRadius = 5
        allWebinorView.layer.cornerRadius = 25
        
    }
    func setUpCell(webinor: Webinor){
        let dateTime = Helper.dateFormatterForDateTime(dateString: webinor.webinarDateTime ?? "")
        self.dateLabel.text = dateTime.0
        self.timeLabel.text = dateTime.1
        self.webinorTitleLabel.text = webinor.webinarTitle
        self.participantsLabel.text = "2K"
        if let url = URL(string: webinor.webinarImage?.value(forKey: "url") as? String ?? "") {
            self.allWebinorImage.kf.setImage(with: url, placeholder: UIImage(named: "screen4.png"))
        }
    }
    
}
