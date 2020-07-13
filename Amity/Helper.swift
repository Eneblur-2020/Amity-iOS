//
//  Helper.swift
//  Amity
//
//  Created by Vinayak Tudayekar on 07/07/20.
//  Copyright © 2020 Eneblur Consulting. All rights reserved.
//

import Foundation
class Helper{
    static func dateFormatterMMMyyyy(dateString:String) -> String {
        
        let dateFormatter = DateFormatter()
        let tempLocale = dateFormatter.locale
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
       
        let date = dateFormatter.date(from: dateString) ?? Date()
        dateFormatter.dateFormat = "MMM yyyy"
        dateFormatter.locale = tempLocale // reset the locale
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    static func dateFormatterMMddWW(dateString:String) -> String {
        
        let dateFormatter = DateFormatter()
        let tempLocale = dateFormatter.locale
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = dateFormatter.date(from: dateString) ?? Date()
        dateFormatter.dateFormat = "MMM yyyy"
        dateFormatter.locale = tempLocale // reset the locale
        let dateString = dateFormatter.string(from: date)
        print(dateString)
        return dateString
    }
    static func dateFormatterForDateTime(dateString:String) -> (String,String) {
        let dateFormatter = DateFormatter()
        let tempLocale = dateFormatter.locale
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        if let date = dateFormatter.date(from: dateString) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM d, EEE   h:mm a"
            dateFormatter.locale = tempLocale
            dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
            let separateDate = dateFormatter.string(from: date)
            let separatedDateTime = separateDate.components(separatedBy: "  ")
            let dateValue = separatedDateTime.first
            let timeValue = separatedDateTime.last
            return (dateValue!,timeValue!)
            
        } else {
            return ("","")
        }
    }
    static func dateFormatter_dd_MM_yyyy(dateString:String) -> String {
        let dateFormatter = DateFormatter()
        let tempLocale = dateFormatter.locale
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "MMM yyyy"
        
        if let date = dateFormatter.date(from: dateString) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy"
            dateFormatter.locale = tempLocale
            dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
            let Date = dateFormatter.string(from: date)
            return Date
        } else {
            return ""
        }
        
    }
    
}



