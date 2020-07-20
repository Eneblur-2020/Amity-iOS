//
//  ApiUtil.swift
//  Amity
//
//  Created by Vinayak Tudayekar on 09/07/20.
//  Copyright © 2020 Eneblur Consulting. All rights reserved.
//

import Foundation
import Alamofire
class ApiUtil{
    static let apiUtil = ApiUtil()
    

    func webinarAPI(completionHandler: @escaping (AnyObject?) -> ()){
        if isInternetAvailable(){
            Util.Manager.request(WEBINAR_API, method : .get, encoding: JSONEncoding.default).responseJSON { (response) in
                switch response.result{
                case .success(_):
                    if let json = response.result.value{
                        if let jsonData = json as? NSDictionary {
                            if let status = jsonData.object(forKey: "status") as? Int {
                                if status == 200{
                                    if let data = jsonData.object(forKey: "data") as? [NSDictionary]{
                                        let webinorData = self.parseWebinorData(webinorData: data)
                                        completionHandler(webinorData as AnyObject)
                                    }
                                }
                            }
                        }
                    }
                    break
                case .failure(_):
                    if (response.response?.statusCode) != nil {
                        
                    }
                    break
                    
                }
            }
        } else {
            //Util.showWhistle(message: NO_INTERNET, viewController: self)
        }
    }
    func parseWebinorData(webinorData:[NSDictionary]) -> [Webinor]{
        
        webinorArray.removeAll()
        for webinor in webinorData{
            let webinorInfo = Webinor()
            if let instructorImage =  webinor.object(forKey: "instructorImage") as? NSDictionary{
                webinorInfo.instructorImage = instructorImage
            }
            if let instructorImageName = webinorInfo.instructorImage?.object(forKey: "name") as? String{
                webinorInfo.instructorImageName = instructorImageName
            }
            if let webinarImage =  webinor.object(forKey: "webinarImage") as? NSDictionary{
                webinorInfo.webinarImage = webinarImage
            }
            if let isActive =  webinor.object(forKey: "isActive") as? Bool{
                webinorInfo.isActive = isActive
            }
            if let id =  webinor.object(forKey: "_id") as? String{
                webinorInfo.id = id
            }
            if let webinarTitle =  webinor.object(forKey: "webinarTitle") as? String{
                webinorInfo.webinarTitle = webinarTitle
            }
            if let instructorName =  webinor.object(forKey: "instructorName") as? String{
                webinorInfo.instructorName = instructorName
            }
            if let instructorDetails =  webinor.object(forKey: "instructorDetails") as? String{
                webinorInfo.instructorDetails = instructorDetails
            }
            if let webinarDateTime =  webinor.object(forKey: "webinarDateTime") as? String{
                print(webinarDateTime)
                webinorInfo.webinarDateTime = webinarDateTime
                let seprateDateTime = Helper.dateFormatterForDateTime(dateString:   webinarDateTime)
                print(seprateDateTime)
                webinorInfo.webinarDate = seprateDateTime.0
                webinorInfo.webinarTime = seprateDateTime.1
            }
            
            if let webinarDetails =  webinor.object(forKey: "webinarDetails") as? String{
                webinorInfo.webinarDetails = webinarDetails
            }
            if let webinarURL =  webinor.object(forKey: "webinarURL") as? String{
                webinorInfo.webinarURL = webinarURL
            }
            if let v =  webinor.object(forKey: "__v") as? Int {
                webinorInfo.v = v
            }
            if let createdAt =  webinor.object(forKey: "createdAt") as? String{
                webinorInfo.createdAt = createdAt
            }
            if let updatedAt =  webinor.object(forKey: "updatedAt") as? String{
                webinorInfo.updatedAt = updatedAt
            }
            webinorArray.append(webinorInfo)
            
        }
        return webinorArray
        
        
    }
    func eventAPI(completionHandler: @escaping (AnyObject?) -> ()){
        if isInternetAvailable(){
            Util.Manager.request(EVENT_API, method : .get, encoding: JSONEncoding.default).responseJSON { (response) in
                switch response.result{
                case .success(_):
                    if let json = response.result.value{
                        if let jsonData = json as? NSDictionary {
                            if let status = jsonData.object(forKey: "status") as? Int {
                                if status == 200{
                                    if let data = jsonData.object(forKey: "data") as? [NSDictionary]{
                                        let eventData = self.parseEventData(eventData: data)
                                        completionHandler(eventData as AnyObject)
                                    }
                                }
                            }
                        }
                    }
                    break
                case .failure(_):
                    if (response.response?.statusCode) != nil {
                        
                    }
                    break
                    
                }
            }
        } else {
            //Util.showWhistle(message: NO_INTERNET, viewController: self)
        }
    }
    func parseEventData(eventData:[NSDictionary]) -> [Event]{
        
        eventArray.removeAll()
        for event in eventData{
            let eventInfo = Event()
            if let eventImage =  event.object(forKey: "eventImage") as? NSDictionary{
                eventInfo.eventImage = eventImage
            }
            if let isActive = event.object(forKey: "isActive") as? Bool{
                eventInfo.isActive = isActive
            }
            if let id = event.object(forKey: "_id") as? String{
                eventInfo.id = id
            }
            if let eventTitle = event.object(forKey: "eventTitle") as? String{
                eventInfo.eventTitle = eventTitle
            }
            if let eventDateTime = event.object(forKey: "eventDateTime") as? String{
                eventInfo.eventDateTime = eventDateTime
                let seprateDateTime = Helper.dateFormatterForDateTime(dateString:   eventDateTime)
                eventInfo.eventDate = seprateDateTime.0
                eventInfo.eventTime = seprateDateTime.1
            
                
            }
            if let eventAddress = event.object(forKey: "eventAddress") as? String{
                eventInfo.eventAddress = eventAddress
            }
            if let eventDetails = event.object(forKey: "eventDetails") as? String{
                eventInfo.eventDetails = eventDetails
            }
            if let eventURL = event.object(forKey: "eventURL") as? String{
                eventInfo.eventURL = eventURL
            }
            if let __v = event.object(forKey: "__v") as? Int{
                eventInfo.v = __v
            }
            if let createdAt = event.object(forKey: "createdAt") as? String {
                eventInfo.createdAt = createdAt
            }
            if let updatedAt = event.object(forKey: "updatedAt") as? String{
                eventInfo.updatedAt = updatedAt
            }
            eventArray.append(eventInfo)
            
        }
        return eventArray
        
        
    }
    
    func galleryAPI(completionHandler: @escaping (AnyObject?) -> ()){
        if isInternetAvailable(){
            Util.Manager.request(GALLERY_API, method : .get, encoding: JSONEncoding.default).responseJSON { (response) in
                switch response.result{
                case .success(_):
                    if let json = response.result.value{
                        if let jsonData = json as? NSDictionary {
                            if let status = jsonData.object(forKey: "status") as? Int {
                                if status == 200{
                                    if let data = jsonData.object(forKey: "data") as? [NSDictionary]{
                                        let galleryData = self.parsegalleryData(galleryData: data)
                                        completionHandler(galleryData as NSArray)
                                    }
                                }
                            }
                        }
                    }
                    break
                case .failure(_):
                    if (response.response?.statusCode) != nil {
                        
                    }
                    break
                    
                }
            }
        } else {
            //Util.showWhistle(message: NO_INTERNET, viewController: self)
        }
    }
    func parsegalleryData(galleryData:[NSDictionary]) -> [Gallery]{
        
        galleryArray.removeAll()
        imageArray.removeAll()
        videoArray.removeAll()
        for gallery in galleryData{
            let galleryInfo = Gallery()
            if let image =  gallery.object(forKey: "image") as? NSDictionary{
                galleryInfo.image = image
            }
            if let imageTitle = gallery.object(forKey: "imageTitle") as? String{
                galleryInfo.imageTitle = imageTitle
            }
            if let id = gallery.object(forKey: "_id") as? String{
                galleryInfo.id = id
            }
            if let type = gallery.object(forKey: "type") as? String{
                galleryInfo.type = type
            }
            
            if let videoLink = gallery.object(forKey: "videoLink") as? String{
                galleryInfo.videoLink = videoLink
            }
            if let videoTitle = gallery.object(forKey: "videoTitle") as? String{
                galleryInfo.videoTitle = videoTitle
            }
            if let __v = gallery.object(forKey: "__v") as? Int{
                galleryInfo.v = __v
            }
            if let createdAt = gallery.object(forKey: "createdAt") as? String {
                galleryInfo.createdAt = createdAt
            }
            if let updatedAt = gallery.object(forKey: "updatedAt") as? String{
                galleryInfo.updatedAt = updatedAt
            }
            if galleryInfo.type == "IMAGE"{
                imageArray.append(galleryInfo)
            } else if galleryInfo.type == "VIDEO"{
                videoArray.append(galleryInfo)
            }
            galleryArray.append(galleryInfo)
            
        }
                return galleryArray
        
        
    }
}
extension Sequence {
    
    func groupBy<G: Hashable>(closure: (Iterator.Element)->G) -> [G: [Iterator.Element]] {
        var results = [G: Array<Iterator.Element>]()
        
        forEach {
            let key = closure($0)
            
            if var array = results[key] {
                array.append($0)
                results[key] = array
            }
            else {
                results[key] = [$0]
            }
        }
        
        return results
    }
}

// Usage


