//
//  Courses.swift
//  Amity
//
//  Created by Snehalatha Desai on 13/07/20.
//  Copyright © 2020 Eneblur Consulting. All rights reserved.
//

import UIKit

class Courses {

    var coursename: String?
    var duration: String?
    var batchdate: String?
    var facultyname: String?
    var courseimg: String?
    var facultyimg: String?
    var descr: String?
     var fees: String?
      var facultydesc: String?
     var courseid: String?
    
    var categoryname: String?
    var categorycode: Int?
    
    var partnerimg : String?
     var learningoutcome : String?
     var curriculum : String?
     var certificate : String?
     var video : String?
     var totregistration : String?
    var coursesurl : String?
    
    struct faculty {
        var fname:String?
        var fimg:String?
        var fdesc:String?
    }
    struct partnerlogo {
           var pimg:String?
          
       }
    var facultydata = [faculty]()
       var partnerslogodata = [partnerlogo]()
}
