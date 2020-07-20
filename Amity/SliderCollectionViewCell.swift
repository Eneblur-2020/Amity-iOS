//
//  SliderCollectionViewCell2.swift
//  Amity
//
//  Created by Vinayak Tudayekar on 28/06/20.
//  Copyright © 2020 Eneblur Consulting. All rights reserved.
//

import UIKit
import Kingfisher
protocol TableViewInsideCollectionViewDelegate:class {
    func onClickWebinarSlider(data:Webinor,indexPath:IndexPath,isFrom:String)
}
protocol ActivityIndicatorDelegate:class {
    func activityIndicatorOnHomePage()
}

class SliderCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var sliderImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var registerButton: UIButton!
  
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setUpCell(webinor: Webinor){
        let dateTime = Helper.dateFormatterForDateTime(dateString: webinor.webinarDateTime ?? "")
        self.titleLabel.text = webinor.webinarTitle
        self.dateLabel.text = dateTime.0
        self.timeLabel.text = dateTime.1
        if let url = URL(string: webinor.webinarImage?.value(forKey: "url") as? String ?? "") {
            self.sliderImage.kf.setImage(with: url, placeholder: UIImage(named: ""))
        }
    }
}
