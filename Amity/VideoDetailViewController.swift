//
//  VideoDetailViewController.swift
//  Amity
//
//  Created by Vinayak Tudayekar on 16/07/20.
//  Copyright © 2020 Eneblur Consulting. All rights reserved.
//

import UIKit

class VideoDetailViewController: BaseViewController {
    @IBOutlet weak var videoCollectionView: UICollectionView!
    
    private let spacing:CGFloat = 5.0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        initialSetUp()
    }
    func initialSetUp(){
        self.title = "Videos"
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        self.videoCollectionView?.collectionViewLayout = layout
    }
}

extension VideoDetailViewController:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        videoArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = videoCollectionView.dequeueReusableCell(withReuseIdentifier: "VideoDetailCollectionViewCell", for: indexPath) as! VideoDetailCollectionViewCell
        cell.setUpCell(gallery: videoArray[indexPath.row])
        return cell
    }
    
    
}
extension VideoDetailViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let  playVideoViewController = Storyboard.Main.instance.instantiateViewController(withIdentifier: "PlayVideoViewController") as! PlayVideoViewController
        playVideoViewController.video = videoArray[indexPath.row]
        self.navigationController?.pushViewController(playVideoViewController, animated: true)
    }
}
extension VideoDetailViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfItemsPerRow:CGFloat = 2
        let spacingBetweenCells:CGFloat = 5
        
        let totalSpacing = (2 * self.spacing) + ((numberOfItemsPerRow - 1) * spacingBetweenCells) //Amount of total spacing in a row
        
        if let collection = self.videoCollectionView{
            let width = (collection.bounds.width - totalSpacing)/numberOfItemsPerRow
            return CGSize(width: width, height: width)
        }else{
            return CGSize(width: 0, height: 0)
        }
    }
}
