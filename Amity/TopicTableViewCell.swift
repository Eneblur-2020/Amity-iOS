//
//  TopicTableViewCell.swift
//  Amity
//
//  Created by Snehalatha Desai on 11/07/20.
//  Copyright © 2020 Eneblur Consulting. All rights reserved.
//

import UIKit

class TopicTableViewCell: UITableViewCell {

    @IBOutlet weak var coursesliderImage: UIImageView!
    @IBOutlet weak var coursename: UILabel!
    @IBOutlet weak var facultyname: UILabel!
    @IBOutlet weak var duration: UILabel!
     @IBOutlet weak var batchdate: UILabel!
    @IBOutlet weak var registerbtn: UIButton!
    @IBOutlet weak var topicview: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //initWithNib()
        // Initialization code
    }
    func initWithNib() {
        topicview.layer.shadowColor = UIColor.black.cgColor
        topicview.layer.shadowOpacity = 1
        topicview.layer.shadowOffset = .zero
        topicview.layer.shadowRadius = 5
        topicview.layer.cornerRadius = 25
        
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
