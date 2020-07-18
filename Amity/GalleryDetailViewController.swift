//
//  GalleryDetailViewController.swift
//  Amity
//
//  Created by Vinayak Tudayekar on 13/07/20.
//  Copyright © 2020 Eneblur Consulting. All rights reserved.
//

import UIKit
import Kingfisher

class GalleryDetailViewController: UIViewController {
    @IBOutlet weak var galleryCollectionView: UICollectionView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var closeButton: UIButton!
    
    private let spacing:CGFloat = 16.0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        self.galleryCollectionView?.collectionViewLayout = layout
        initialSetUp()
    }
    func initialSetUp(){
        self.imageView.isHidden = true
        self.closeButton.isHidden = true
        self.galleryCollectionView.alpha = 1.0
        self.galleryCollectionView.isUserInteractionEnabled = true
        self.galleryCollectionView?.isOpaque = true
        self.galleryCollectionView?.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
    }
    @IBAction func onClickCloseButton(_ sender:Any){
       initialSetUp()
    }
}

extension GalleryDetailViewController:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryDetailCollectionViewCell", for: indexPath) as! GalleryDetailCollectionViewCell
        cell.setUpCell(gallery: imageArray[indexPath.row])
        return cell
    }
    
    
}
extension GalleryDetailViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
      
        self.imageView.isHidden = false
        self.closeButton.isHidden = false
        self.galleryCollectionView.alpha = 0.8
        self.galleryCollectionView?.isOpaque = false
        self.galleryCollectionView?.backgroundColor = UIColor(red: 0.7, green: 0.7, blue: 0.8, alpha: 0.8)
         self.galleryCollectionView.isUserInteractionEnabled = false
        if let url = URL(string: imageArray[indexPath.row].image?.value(forKey: "url") as? String ?? "") {
            self.imageView.kf.setImage(with: url, placeholder: UIImage(named: ""))
        }
        
        
    }
}
extension GalleryDetailViewController: UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfItemsPerRow:CGFloat = 2
        let spacingBetweenCells:CGFloat = 32
        
        let totalSpacing = (2 * self.spacing) + ((numberOfItemsPerRow - 1) * spacingBetweenCells) //Amount of total spacing in a row
        
        if let collection = self.galleryCollectionView{
            let width = (collection.bounds.width - totalSpacing)/numberOfItemsPerRow
            return CGSize(width: width, height: width)
        }else{
            return CGSize(width: 0, height: 0)
        }
    }
}
