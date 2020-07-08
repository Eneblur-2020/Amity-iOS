//
//  DataViewController.swift
//  Amity
//
//  Created by Vinayak Tudayekar on 23/06/20.
//  Copyright © 2020 Eneblur Consulting. All rights reserved.
//

import UIKit

class DataViewController: UIViewController {
    
    @IBOutlet weak var PageContainerView: UIView!
    @IBOutlet weak var letsStartButton: UIButton!
    @IBOutlet weak var circleView: UIView!

    var semiCircleLayer   = CAShapeLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      // initalSetUp()
        
        // Do any additional setup after loading the view.
    }
    func initalSetUp(){
        
      //  let center = CGPoint (x: circleView.frame.size.width / 2, y: circleView.frame.size.height / 2)
        let center = CGPoint (x: self.view.frame.size.width / 2, y: self.view.frame.size.height / 2)
          let circleRadius = circleView.frame.size.width / 2
          let circlePath = UIBezierPath(arcCenter: center, radius: circleRadius,startAngle: CGFloat(M_PI), endAngle: CGFloat(M_PI * 2), clockwise: true)
          circleView.layer.cornerRadius = 100
          PageContainerView.backgroundColor = #colorLiteral(red: 0, green: 0.1882352941, blue: 0.368627451, alpha: 1)
          semiCircleLayer.path = circlePath.cgPath
          semiCircleLayer.strokeColor = #colorLiteral(red: 0.2509803922, green: 0.4392156863, blue: 0.6235294118, alpha: 1)
          semiCircleLayer.fillColor = UIColor.clear.cgColor
          semiCircleLayer.lineWidth = 40
          semiCircleLayer.strokeStart = 0
          semiCircleLayer.strokeEnd  = 1
          circleView.layer.addSublayer(semiCircleLayer)
        PageContainerView.addSubview(circleView)
        
    }
    
    @IBAction func onClickLetsStartButton(_ sender: Any) {
        self.performSegue(withIdentifier: "signUp", sender: self)
    }
    
}


