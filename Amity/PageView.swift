//
//  PageView.swift
//  Amity
//
//  Created by Abhishek Jadhav on 23/06/20.
//  Copyright © 2020 Eneblur Consulting. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class PageView: UIView {

    @IBOutlet weak var pageName: UILabel!
    @IBOutlet weak var pageImageView: UIImageView!
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var descriptionImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var circleView: UIView!
    @IBOutlet weak var topView: UIView!
    
    static let pageViewItemNib = "PageView"
    var index = 0
    var semiCircleLayer   = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initWithNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initWithNib()
       
    }
    
    convenience init(titleText: String, image: UIImage, description: String, descriptionImage:UIImage,index:Int) {
        self.init()
        pageName.text = titleText
        pageImageView.image = image
        descriptionLabel.text = description
        descriptionImageView.image = descriptionImage
        self.index = index
        if   self.index != 0 {
            descriptionImageView.isHidden = true
        }
    
    }
    
    func initWithNib() {
        Bundle.main.loadNibNamed(PageView.pageViewItemNib, owner: self, options: nil)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        addSubview(contentView)
        
    }
    
   
}

extension UIView {
    
    class func fromNib<T: UIView>() -> T{
        Bundle(for: T.self).loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}
