//
//  TopicSliderTableViewCell.swift
//  Amity
//
//  Created by Snehalatha Desai on 10/07/20.
//  Copyright © 2020 Eneblur Consulting. All rights reserved.
//

import UIKit

class TopicSliderTableViewCell:  UITableViewCell,UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var topicCollectionView: UICollectionView!
    var coursedata = [Courses]()
    var selectedcode = Int()
var topic_Action: (() -> Void)? = nil
    
       //var timer : Timer!
    var arrayOfTopics = ["Artificial Intelligence","Technology Management","Digital Marketing","AI/ML","Blockchain","Data Science","Security"]
   
    override func awakeFromNib() {
        super.awakeFromNib()
        self.topicCollectionView.register(UINib(nibName: "TopicSliderCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TopicSliderCollectionViewCell")
        self.topicCollectionView.delegate = self
        self.topicCollectionView.dataSource = self
        self.topicCollectionView.reloadData()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
       
    }

   
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 140.0 , height: 68.0)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return coursedata.count
    }
    
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         let data = coursedata[indexPath.item]
        selectedcode = data.categorycode!
    topic_Action?()
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopicSliderCollectionViewCell", for: indexPath) as! TopicSliderCollectionViewCell
        let data = coursedata[indexPath.item]
        cell.topicname.text =  data.categoryname
        print("topic name",data.categoryname)
        return cell
    }
        
   
    
} // main class close
