//
//  HomePage1ViewController.swift
//  Amity
//
//  Created by Vinayak Tudayekar on 27/06/20.
//  Copyright © 2020 Eneblur Consulting. All rights reserved.
//

import UIKit

class HomePage1ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var sections = ["","All Webinars","All Events","Gallery"]
    var sectionLabel = ["","Preview Upcoming Webinars","Upcoming Events","Recent Photos and Videos"]
    var sectionButtonArray = ["VIEW ALL","VIEW ALL",]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.delegate = self
        tableView.dataSource = self
        registerTableViewcell()
        
    }
    func registerTableViewcell(){
        self.tableView.register(UINib(nibName: "SliderTableViewCell", bundle: nil), forCellReuseIdentifier: "SliderTableViewCell")
        self.tableView.register(UINib(nibName: "AllWebinarTableViewCell", bundle: nil), forCellReuseIdentifier: "AllWebinarTableViewCell")
        self.tableView.register(UINib(nibName: "AllEventsTableViewCell", bundle: nil), forCellReuseIdentifier: "AllEventsTableViewCell")
         self.tableView.register(UINib(nibName: "GalleryTableViewCell", bundle: nil), forCellReuseIdentifier: "GalleryTableViewCell")
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.white
        let label = UILabel()
        label.textColor = UIColor(named: "TitleBlackColour")
        label.frame = CGRect(x: 20, y: 10, width: 400, height: 40)
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.text = sections[section]
        
        let detailLabel = UILabel()
        detailLabel.textColor = UIColor(named: "GreyColour")
        detailLabel.frame = CGRect(x: 20, y: 40, width: 400, height: 40)
        detailLabel.numberOfLines = 0
        detailLabel.lineBreakMode = .byWordWrapping
        detailLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        detailLabel.text = sectionLabel[section]
        view.addSubview(label)
        view.addSubview(detailLabel)
        
        
        let button = UIButton(frame: CGRect(x: UIScreen.main.bounds.size.width - 140, y: 10, width: 120, height: 40))
        button.setTitle("VIEW ALL", for: .normal)
        button.cornerRadius = 10
        button.setTitleColor(UIColor(named: "DarkBlueColour"), for: .normal)
        button.tag = section
        button.addTarget(self, action: #selector(onClickViewAllButton), for: .touchUpInside)
        
        button.backgroundColor = UIColor(named: "DarkYellowColour")
        view.addSubview(button)
        
        return view
    }
    @objc func onClickViewAllButton(){
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 280
        }
        else{
            return 300
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
            return 0
        }
        else{
            return 90
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SliderTableViewCell") as! SliderTableViewCell
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier:"AllWebinarTableViewCell" ) as! AllWebinarTableViewCell
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier:"AllEventsTableViewCell" ) as! AllEventsTableViewCell
            return cell
        case 3:
             let cell = tableView.dequeueReusableCell(withIdentifier:"GalleryTableViewCell" ) as! GalleryTableViewCell
            return cell
        default:
            UITableViewCell()
        }
        
        return UITableViewCell()
        
    }
}

