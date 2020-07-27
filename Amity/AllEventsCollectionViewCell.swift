//
//  AllEventsCollectionViewCell.swift
//  Amity
//
//  Created by Vinayak Tudayekar on 05/07/20.
//  Copyright © 2020 Eneblur Consulting. All rights reserved.
//

import UIKit
protocol EventsCollectionViewDelegate:class {
    func onClickEventsCollectionCell(data:Event,indexPath:IndexPath,isFrom:String)
}
class AllEventsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var allEventsImage: UIImageView!
    @IBOutlet weak var alleventsLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        // Initialization code
    }
    func setUpCell(event: Event){
        self.alleventsLabel.text = event.eventTitle
        if let url = URL(string: event.eventImage?.value(forKey: "url") as? String ?? "") {
            self.allEventsImage.kf.setImage(with: url, placeholder: UIImage(named: ""))
        }
    }

}
