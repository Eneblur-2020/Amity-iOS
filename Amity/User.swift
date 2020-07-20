//
//  User.swift
//  Amity
//
//  Created by Vinayak Tudayekar on 06/07/20.
//  Copyright © 2020 Eneblur Consulting. All rights reserved.
//

import Foundation
struct User {
    var email:String?
    var roleId:NSDictionary?
    var name:String?
    var contactNumber:String?
    var userMetaData:NSDictionary?
}
struct roleId {
    var displayName:String?
    var _id:String?
    var description:String?
}
struct userMetaData {
    var name:String?
    var constactNumber:String?
}
