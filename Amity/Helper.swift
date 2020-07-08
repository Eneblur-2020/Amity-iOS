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
     dateFormatter.locale = Locale(identifier: "en_US_POSIX")
     dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: dateString) ?? Date()
     dateFormatter.dateFormat = "MMM yyyy"
     dateFormatter.locale = tempLocale // reset the locale
     let dateString = dateFormatter.string(from: date)
        print(dateString)
    return dateString
    }
}
