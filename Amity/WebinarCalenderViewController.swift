//
//  WebinarCalenderViewController.swift
//  Amity
//
//  Created by Vinayak Tudayekar on 10/07/20.
//  Copyright © 2020 Eneblur Consulting. All rights reserved.
//

import UIKit
import Foundation
import FSCalendar

class WebinarCalenderViewController: UIViewController {
    
    @IBOutlet weak var calender: FSCalendar!
    @IBOutlet weak var allWebinorCollectionView: UICollectionView!
    @IBOutlet weak var webinarEventSearchBar: UISearchBar!
    @IBOutlet weak var searchResultForLabel: UILabel!
    
    @IBOutlet weak var viewAllButton: UIButton!
    var tag: Int?
    var isFrom:String?
    var filteredWebinorArray = [Webinor]()
    var filteredEventArray = [Event]()
    var selectedDate = [String]()
    var searchActive : Bool = false
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, EEE"
        return formatter
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        initialCalenderSetUp()
        initialSetUp()
        
        
        // Do any additional setup after loading the view.
    }
    @IBAction func onClickViewAllButton(_ sender: Any) {
        if isFrom == WEBINAR {
            filteredWebinorArray = webinorArray
            searchResultForLabel.text = "All Webinar"
        } else {
            filteredEventArray = eventArray
            searchResultForLabel.text = "All Events"
        }
        self.resignFirstResponder()
        allWebinorCollectionView.reloadData()
        viewAllButton.isHidden = true
        
    }
    func initialSetUp(){
        if isFrom == WEBINAR {
            filteredWebinorArray = webinorArray
            self.title = "WEBINAR"
            searchResultForLabel.text = "All Webinar"
            webinarEventSearchBar.placeholder = "Find webinar"
        } else {
            filteredEventArray = eventArray
            self.title = "EVENTS"
            searchResultForLabel.text = "All Events"
            webinarEventSearchBar.placeholder = "Find an event"
        }
        
        
        self.viewAllButton.isHidden = true
        self.allWebinorCollectionView.register(UINib(nibName: "WebinarCalenderCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "WebinarCalenderCollectionViewCell")
    }
    func initialCalenderSetUp(){
        self.calender.scope = .week
        self.calender.appearance.borderRadius = 0
        
    }
}
extension WebinarCalenderViewController: FSCalendarDelegate{
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("did select date \(self.dateFormatter.string(from: date))")
        selectedDate = calendar.selectedDates.map({self.dateFormatter.string(from: $0)})
        if monthPosition == .next || monthPosition == .previous {
            calendar.setCurrentPage(date, animated: true)
        }
        viewAllButton.isHidden = false
        if isFrom == WEBINAR {
            filteredWebinorArray = webinorArray.filter({$0.webinarDate == selectedDate[0]})
            searchResultForLabel.text = filteredWebinorArray.count == 0 ? "No Result for " + selectedDate[0] : "Result for " + selectedDate[0]
        } else {
            filteredEventArray = eventArray.filter({$0.eventDate == selectedDate[0]})
            searchResultForLabel.text = filteredEventArray.count == 0 ? "No Result for " + selectedDate[0] : "Result for " + selectedDate[0]
        }
        
        allWebinorCollectionView.reloadData()
        
    }
    
}
extension WebinarCalenderViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isFrom == WEBINAR {
            return filteredWebinorArray.count
        } else {
            return filteredEventArray.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WebinarCalenderCollectionViewCell", for: indexPath) as! WebinarCalenderCollectionViewCell
        cell.registerButton.addTarget(self, action: #selector(onRegisterButtonClick), for: .touchUpInside)
        cell.registerButton.tag = indexPath.row
        var height = allWebinorCollectionView.collectionViewLayout.collectionViewContentSize.height
        self.view.layoutIfNeeded()
        if isFrom == WEBINAR {
            cell.setUpCell(webinor: filteredWebinorArray[indexPath.row])
        } else {
            cell.setUpEventCell(event: filteredEventArray[indexPath.row])
        }
        
        return cell
        
    }
    @objc func onRegisterButtonClick(_ sender:UIButton){
        let indexPath = IndexPath(row: sender.tag, section: 0)
        let webinorDetailViewController = Storyboard.Main.instance.instantiateViewController(withIdentifier: "WebinorDetailViewController") as! WebinorDetailViewController
        if isFrom == WEBINAR {
            webinorDetailViewController.isFrom = WEBINAR
            webinorDetailViewController.webinarData = filteredWebinorArray[indexPath.row]
        } else {
            webinorDetailViewController.isFrom = "EVENTS"
            webinorDetailViewController.eventsData = filteredEventArray[indexPath.row]
        }
        self.navigationController?.pushViewController(webinorDetailViewController, animated: true)
    }
    
    
}
extension WebinarCalenderViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let webinorDetailViewController = Storyboard.Main.instance.instantiateViewController(withIdentifier: "WebinorDetailViewController") as! WebinorDetailViewController
        if isFrom == WEBINAR {
            webinorDetailViewController.isFrom = WEBINAR
            webinorDetailViewController.webinarData = filteredWebinorArray[indexPath.row]
        } else {
            webinorDetailViewController.isFrom = "EVENTS"
            webinorDetailViewController.eventsData = filteredEventArray[indexPath.row]
        }
        self.navigationController?.pushViewController(webinorDetailViewController, animated: true)
    }
}

extension WebinarCalenderViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width:collectionView.frame.width/2,height:collectionView.frame.height)
        
    }
}
extension WebinarCalenderViewController:UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false
        searchBar.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
        searchBar.endEditing(true)
        self.allWebinorCollectionView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
        searchBar.endEditing(true)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewAllButton.isHidden = false
        if isFrom == WEBINAR {
            filteredWebinorArray = webinorArray.filter { text in
                
                return ((text.webinarTitle?.lowercased() as AnyObject).contains(searchText.lowercased()))
                
            }
            searchResultForLabel.text = filteredWebinorArray.count == 0 ? "No Result for " + searchText : "Result for " + searchText
            if(filteredWebinorArray.count == 0){
                searchActive = false
                
            } else {
                searchActive = true
            }
        } else {
            filteredEventArray = eventArray.filter { event in
                
                return ((event.eventTitle?.lowercased() as AnyObject).contains(searchText.lowercased()))
                
            }
            searchResultForLabel.text = filteredEventArray.count == 0 ? "No Result for " + searchText : "Result for " + searchText
            if(filteredEventArray.count == 0){
                searchActive = false
                
            } else {
                searchActive = true
            }
        }
        self.allWebinorCollectionView.reloadData()
    }
    
    
}
