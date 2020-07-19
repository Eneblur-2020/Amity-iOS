//
//  imageview.swift
//  Amity
//
//  Created by Snehalatha Desai on 13/07/20.
//  Copyright © 2020 Eneblur Consulting. All rights reserved.
//

import UIKit

extension UIImageView {
public func imageFromServer(urlString: String) {
    self.image = nil
    if urlString == "" || urlString == nil
    {
        let image = UIImage.init(named: "placeholder")
                  self.image = image
    }
    else
    {
    URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in

        if error != nil {
            print(error)
            return
        }
        DispatchQueue.main.async(execute: { () -> Void in
            let image = UIImage(data: data!)
            self.image = image
        })

    }).resume()
    }
}}
