//
//  Gallery.swift
//  Amity
//
//  Created by Vinayak Tudayekar on 09/07/20.
//  Copyright © 2020 Eneblur Consulting. All rights reserved.
//

import Foundation
class Gallery {
    var image: NSDictionary?
    var id: String?
    var imageTitle: String?
    var type:String?
    var v: Int?
    var createdAt: String?
    var updatedAt: String?
    var videoTitle: String?
    var videoLink: String?
    
}

struct GalleryDaya : Codable {
    let status : Int?
    let message : String?
    let data : [imageData]?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case message = "message"
        case data = "data"
    }

   

}
struct Image : Codable {
    let fileName : String?
    let basePath : String?
    let url : String?

    enum CodingKeys: String, CodingKey {

        case fileName = "fileName"
        case basePath = "basePath"
        case url = "url"
    }

}
struct imageData : Codable {
    let image : Image?
    let _id : String?
    let imageTitle : String?
    let type : String?
    let __v : Int?
    let createdAt : String?
    let updatedAt : String?

    enum CodingKeys: String, CodingKey {

        case image = "image"
        case _id = "_id"
        case imageTitle = "imageTitle"
        case type = "type"
        case __v = "__v"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
    }

   
}

