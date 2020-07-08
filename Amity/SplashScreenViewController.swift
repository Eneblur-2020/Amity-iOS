//
//  SplashScreenViewController.swift
//  Amity
//
//  Created by swapna raddi on 16/05/20.
//  Copyright © 2020 Eneblur Consulting. All rights reserved.
//

import UIKit

class SplashScreenViewController: UIViewController {
    @IBOutlet weak var circleView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var startButton: UIView!
    
    var semiCircleLayer   = CAShapeLayer()
    
//    var imgArr = [UIImage (named: "screen1"),
//                  UIImage(named: "screen2"),
//                  UIImage(named: "screen3"),
//                  UIImage(named: "screen4")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Circle Points
        let center = CGPoint (x: circleView.frame.size.width / 2, y: circleView.frame.size.height / 2)
        let circleRadius = circleView.frame.size.width / 2
        let circlePath = UIBezierPath(arcCenter: center, radius: circleRadius,startAngle: CGFloat(M_PI), endAngle: CGFloat(M_PI * 2), clockwise: true)
        circleView.layer.cornerRadius = 25


        semiCircleLayer.path = circlePath.cgPath
        semiCircleLayer.strokeColor = UIColor.orange.cgColor
        semiCircleLayer.fillColor = UIColor.white.cgColor
        semiCircleLayer.lineWidth = 40
        semiCircleLayer.strokeStart = 0
        semiCircleLayer.strokeEnd  = 1
        circleView.layer.addSublayer(semiCircleLayer)
        
//        self.mainView.backgroundColor = UIColor(named:"#00305E")
         
    }
 
}




