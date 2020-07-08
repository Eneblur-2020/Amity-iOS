//
//  semiCircleView.swift
//  Amity
//
//  Created by Vinayak Tudayekar on 29/06/20.
//  Copyright © 2020 Eneblur Consulting. All rights reserved.
//

import UIKit

class semiCircleView: UIView {
    
       
        var circleView: UIImageView!
     var semiCircleLayer   = CAShapeLayer()

       
        var image: UIImage? {
            get { return circleView.image }
            set { circleView.image = newValue }
        }

        required init(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)!
            initSubviews()
        }

        override init(frame: CGRect) {
            super.init(frame: frame)
            initSubviews()
        }

        func initSubviews() {
            
            let center = CGPoint (x: self.frame.size.width / 2, y: self.frame.size.height / 2)
             let circleRadius = self.frame.size.width / 2
              let circlePath = UIBezierPath(arcCenter: center, radius: circleRadius,startAngle: CGFloat(M_PI), endAngle: CGFloat(M_PI * 2), clockwise: true)
              self.layer.cornerRadius = 20
              semiCircleLayer.path = circlePath.cgPath
              semiCircleLayer.strokeColor = #colorLiteral(red: 0.2509803922, green: 0.4392156863, blue: 0.6235294118, alpha: 1)
              semiCircleLayer.fillColor = UIColor.clear.cgColor
              semiCircleLayer.lineWidth = 40
              semiCircleLayer.strokeStart = 0
              semiCircleLayer.strokeEnd  = 1
              self.layer.addSublayer(semiCircleLayer)
            //PageContainerView.addSubview(circleView)
            // sets the image's frame to fill our view
           
        }
    }
