//
//  CircleImageview.swift
//  Amity
//
//  Created by Snehalatha Desai on 11/07/20.
//  Copyright © 2020 Eneblur Consulting. All rights reserved.
//

import UIKit

class CircleImageview: UIImageView {

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
   override func layoutSubviews() {
    super.layoutSubviews()
   self.layer.cornerRadius = (self.frame.size.width ) / 2
    self.clipsToBounds = true
    self.layer.borderWidth = 3.0
    self.layer.borderColor = UIColor.white.cgColor
    }
    

}
