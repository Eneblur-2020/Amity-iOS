//
//  AllAlbumViewController.swift
//  Amity
//
//  Created by Vinayak Tudayekar on 20/07/20.
//  Copyright © 2020 Eneblur Consulting. All rights reserved.
//

import UIKit
import Kingfisher

class AllAlbumViewController: UIViewController {
    @IBOutlet weak var allAlbumCollectionView: UICollectionView!
    @IBOutlet weak var imageView: UIImageView!
    private let spacing:CGFloat = 16.0
    var allalbumData : Gallery?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        initialSetUp()
    }
    override func viewWillAppear(_ animated: Bool) {
        
        imageArray = galleryArray
    }
    func initialSetUp(){
        
        self.title = "ALL ALBUMS"
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        self.allAlbumCollectionView?.collectionViewLayout = layout
    }
}
extension AllAlbumViewController:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        uniqueimageArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AllAlbumCollectionViewCell", for: indexPath) as! AllAlbumCollectionViewCell
              cell.setUpCell(gallery: uniqueimageArray[indexPath.row])
              return cell
    }

    
    
}
extension AllAlbumViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "GalleryDetailViewController") as? GalleryDetailViewController {
           
            //nextViewController.eventsData = data
            //nextViewController.isFrom = isFrom
            // let data = imageArray[indexPath.row]
            imageArray = imageArray.filter {
                $0.imageTitle == uniqueimageArray[indexPath.row].imageTitle


         }
            nextViewController.pageTitle = imageArray[0].imageTitle ?? ""
            self.navigationController?.pushViewController(nextViewController, animated: true)
        }
    }
}
extension AllAlbumViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfItemsPerRow:CGFloat = 2
        let spacingBetweenCells:CGFloat = 32
        
        let totalSpacing = (2 * self.spacing) + ((numberOfItemsPerRow - 1) * spacingBetweenCells) //Amount of total spacing in a row
        
        if let collection = self.allAlbumCollectionView{
            let width = (collection.bounds.width - totalSpacing)/numberOfItemsPerRow
            return CGSize(width: width, height: width)
        }else{
            return CGSize(width: 0, height: 0)
        }
    }
 
}

