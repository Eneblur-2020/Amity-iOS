//
//  Util.swift
//  Amity
//
//  Created by Vinayak Tudayekar on 02/07/20.
//  Copyright © 2020 Eneblur Consulting. All rights reserved.
//

import Foundation
import SystemConfiguration
import UIKit
import Alamofire
import Whisper


func isInternetAvailable() -> Bool{
    var zeroAddress = sockaddr_in()
    zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
    zeroAddress.sin_family = sa_family_t(AF_INET)
    
    let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
        $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
            SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
        }
    }
    var flags = SCNetworkReachabilityFlags()
    if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
        return false
    }
    let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
    let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
    return (isReachable && !needsConnection)
}
class Util{
    
    /**
     Custom Alamofire manager to manage server trust policies if the URL ceritifcate is not valid
     */
    static var Manager : Alamofire.SessionManager = { // Create the server trust policies
        
        let serverTrustPolicies: [String: ServerTrustPolicy] = [POLICY_URL: .disableEvaluation ] // Create custom manager
        let configuration = URLSessionConfiguration.default
        // Setting timeout for request
        configuration.timeoutIntervalForResource = 15 // seconds
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        let man = Alamofire.SessionManager( configuration: URLSessionConfiguration.default, serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies) )
        return man
        
    }()
    
    
    /**
     - parameters:
     - fileName: Name of the JSON file which needs to be converted to NSDictionary
     
     - returns: Dictionary converted from JSON fetched from the file.
     */
    static func getJSON(fileName: String) -> NSDictionary {
        
        var  jsonResult : NSDictionary = NSDictionary()
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                let jsonData = try NSData(contentsOfFile: path, options: NSData.ReadingOptions.alwaysMapped)
                
                do {
                    jsonResult =  try JSONSerialization.jsonObject(with: jsonData as Data, options: .mutableContainers) as! NSDictionary
                    
                } catch let myJSONError {
                    print(myJSONError)
                }
                
            } catch let error {
                print(error)
            }
        }
        return jsonResult
    }
    
    /**
     - parameters:
     - fileName: Name of the JSON Array file which needs to be converted to NSDictionary
     
     - returns: Array converted from JSONArray fetched from the file.
     */
    static func getJSONArray(fileName: String) -> NSArray {
        
        var  jsonResult = NSArray()
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                let jsonData = try NSData(contentsOfFile: path, options: NSData.ReadingOptions.mappedIfSafe)
                
                do {
                    jsonResult =  try JSONSerialization.jsonObject(with: jsonData as Data, options: .mutableContainers) as! NSArray
                } catch let myJSONError {
                    print(myJSONError)
                }
                
            } catch let error {
                print(error)
            }
        }
        return jsonResult
        
    }
    
    
    /**
     - parameters:
     - text: JSON string which needs to be converted to Dictionary
     
     - returns: Dictionary converted from JSON string.
     */
    static func convertStringToDictionary(text: String) -> [String:AnyObject]? {
        
        if let regex = try? NSRegularExpression(pattern: "new Date.-{0,1}\\d{0,13}.", options: .caseInsensitive) {
            let detailInfoString = regex.stringByReplacingMatches(in: text, options: .withTransparentBounds, range: NSMakeRange(0, text.count), withTemplate: "null")
            
            if let data = detailInfoString.data(using: String.Encoding.utf8) {
                do {
                    return try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject]
                } catch let error as NSError {
                    print(error)
                }
            }
        }
        return nil
    }
    
    
    /**
     To show error message if Alamofire block returns in Failure. If internet connection is available it shows Request timed out  else No internet connection
     - parameters:
     - sender: View controller on which the message is to be shown
     
     */
    static func displayFailureMessage(sender: UIViewController){
        if isInternetAvailable(){
            Util.showWhistle(message: REQUEST_TIME_OUT, viewController: sender)
        }else{
            Util.showWhistle(message: NO_INTERNET, viewController: sender)
        }
    }
    
    
}
extension Util {
    static func showWhistle(message : String, viewController : UIViewController){
           var murmur = Murmur(title: message)
           murmur.backgroundColor = UIColor.red
           murmur.titleColor = UIColor.white
           Whisper.show(whistle: murmur, action: .show(0.5))
           Whisper.show(whistle: murmur, action: .present)
           Whisper.hide(whistleAfter: 3)
       }
    static func showAlert(message : String,viewController : UIViewController,title: String? = nil){
        let attributeString = NSMutableAttributedString(string: message, attributes: [NSAttributedString.Key.font: SECONDARY_FONT!])
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.setValue(attributeString, forKey: "attributedMessage")
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
        viewController.present(alert, animated: true, completion: nil)
    }
}
var vSpinner : UIView?

extension UIViewController {
    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        vSpinner = spinnerView
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            vSpinner?.removeFromSuperview()
            vSpinner = nil
        }
    }
}
