//
//  WebinorDetailViewController.swift
//  Amity
//
//  Created by Vinayak Tudayekar on 10/07/20.
//  Copyright © 2020 Eneblur Consulting. All rights reserved.
//

import UIKit
import Kingfisher

class WebinorDetailViewController: UIViewController {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var webinarImage: UIImageView!
    @IBOutlet weak var webinarTitle: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var totalRegistrationCountlabel: UILabel!
    @IBOutlet weak var instructorImage: UIImageView!
    @IBOutlet weak var instructorName: UILabel!
    @IBOutlet weak var webinarDetails:UILabel!
    @IBOutlet weak var instructorContentView:UIView!
    @IBOutlet weak var instructorViewHeightLayoutConstraint: NSLayoutConstraint!
    @IBOutlet weak var venueLabel:UILabel!
    var webinarData: Webinor? = nil
    var eventsData: Event? = nil
    var isFrom: String?
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetUp()
        // Do any additional setup after loading the view.
    }
    
    func initialSetUp(){
    
        if isFrom == WEBINOR {
        webinarDetail()
            self.title = "WEBINAR"
        } else {
            self.title = "EVENTS"
        eventsDetail()
            
        }
       
    }
    
    func webinarDetail(){
         self.instructorViewHeightLayoutConstraint.constant = 168
        self.instructorContentView.isHidden = false
        self.venueLabel.isHidden = true
        if let url = URL(string: webinarData?.webinarImage?.value(forKey: "url") as? String ?? "") {
            self.webinarImage.kf.setImage(with: url, placeholder: UIImage(named: ""))
        }
        self.webinarTitle.text = webinarData?.webinarTitle
        self.dateLabel.text = "Date: " + (webinarData?.webinarDate ?? "")
        self.timeLabel.text = "Time: " + (webinarData?.webinarTime ?? "")
        self.totalRegistrationCountlabel.text = "150"
        if let url = URL(string: webinarData?.instructorImage?.value(forKey: "url") as? String ?? "") {
            self.instructorImage.kf.setImage(with: url, placeholder: UIImage(named: "screen4.png"))
        }
        self.instructorName.text = webinarData?.instructorName
        self.webinarDetails.text = webinarData?.webinarDetails
    }
    func eventsDetail(){
        self.instructorViewHeightLayoutConstraint.constant = 0
        self.instructorContentView.isHidden = true
         self.venueLabel.isHidden = false
        if let url = URL(string: eventsData?.eventImage?.value(forKey: "url") as? String ?? "") {
            self.webinarImage.kf.setImage(with: url, placeholder: UIImage(named: ""))
        }
        
        self.webinarTitle.text = eventsData?.eventTitle
        self.dateLabel.text = "Date: " + (eventsData?.eventDate ?? "")
        self.timeLabel.text = "Time: " + (eventsData?.eventTime ?? "")
        self.totalRegistrationCountlabel.text = "150"
        self.venueLabel.text = "Venue: " + (eventsData?.eventAddress ?? "")
        self.webinarDetails.text = eventsData?.eventDetails
    }
    
    
}
