//
//  WebinarCalenderCollectionViewCell.swift
//  Amity
//
//  Created by Vinayak Tudayekar on 12/07/20.
//  Copyright © 2020 Eneblur Consulting. All rights reserved.
//

import UIKit

class WebinarCalenderCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var allWebinorView: UIView!
    @IBOutlet weak var allWebinorImage: UIImageView!
    @IBOutlet weak var webinorTitleLabel: UILabel!
    @IBOutlet weak var participantsLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var registerButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setUpCell(webinor: Webinor){
        self.dateLabel.isHidden = false
        self.timeLabel.isHidden = false
        self.participantsLabel.isHidden = false
        self.registerButton.isHidden = false
        self.dateLabel.text = webinor.webinarDate
        self.timeLabel.text = webinor.webinarTime
        self.webinorTitleLabel.text = webinor.webinarTitle
        self.participantsLabel.text = "2K"
        if let url = URL(string: webinor.webinarImage?.value(forKey: "url") as? String ?? "") {
            self.allWebinorImage.kf.setImage(with: url, placeholder: UIImage(named: "screen4.png"))
        }
    }
    func setUpEventCell(event: Event){
        self.dateLabel.isHidden = true
        self.timeLabel.isHidden = true
        self.participantsLabel.isHidden = true
        self.registerButton.isHidden = true
        collectionViewHeight.constant = 180
        
        //self.timeLabel.text = event.eventTime
        self.webinorTitleLabel.text = event.eventTitle
        //  self.participantsLabel.text = "2K"
        if let url = URL(string: event.eventImage?.value(forKey: "url") as? String ?? "") {
            self.allWebinorImage.kf.setImage(with: url, placeholder: UIImage(named: "screen4.png"))
        }
    }
}
