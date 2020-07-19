//
//  DynamicheightColeectionView.swift
//  Amity
//
//  Created by Snehalatha Desai on 11/07/20.
//  Copyright © 2020 Eneblur Consulting. All rights reserved.
//

import UIKit

class DynamicheightColeectionView: UICollectionView {

    override func layoutSubviews() {
       super.layoutSubviews()
        if !__CGSizeEqualToSize(bounds.size, self.intrinsicContentSize) {
            self.invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return contentSize
    }
}
