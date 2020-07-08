//
//  HomeViewController.swift
//  Amity
//
//  Created by swapna raddi on 03/06/20.
//  Copyright © 2020 Eneblur Consulting. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var collectionview: UICollectionView!
    @IBOutlet weak var pageView: UIPageControl!
    
    var imgArr = [ UIImage(named: "screen1"), UIImage(named: "screen2")
    ,UIImage(named: "screen3"), UIImage(named: "screen4")]
    
    var timer = Timer()
    var counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageView.numberOfPages = imgArr.count
        pageView.currentPage = 0
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        }
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(changeImage), userInfo: nil, repeats: true)
    }
    
    @objc func changeImage(){
        if counter < imgArr.count {
            let index = IndexPath.init(item: counter, section: 0)
            self.collectionview.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            pageView.currentPage = counter
            counter += 1
        } else {
            counter = 0
            let index = IndexPath.init(item: counter, section: 0)
            self.collectionview.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            pageView.currentPage = counter
        }
    }
}



extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        if let vc = cell.viewWithTag(111) as? UIImageView {
            vc.image = imgArr[indexPath.row]
        }
        else if let ab = cell.viewWithTag(222) as? UIPageControl{
            ab.currentPage = indexPath.row
        }
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.size
        return CGSize(width: size.width, height: size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
}
