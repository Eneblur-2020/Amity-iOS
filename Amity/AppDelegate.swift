//
//  AppDelegate.swift
//  Amity
//
//  Created by swapna raddi on 15/05/20.
//  Copyright © 2020 Eneblur Consulting. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {


    let window: UIWindow? = nil
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
//        if (UserDefaults.standard.value(forKey: "Login") != nil){
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                let dashboardViewController: HomePage1ViewController = storyboard.instantiateViewController(withIdentifier: "HomePage1ViewController") as! HomePage1ViewController
//
//                 var navigationController = UINavigationController()
//            navigationController = UINavigationController(rootViewController: dashboardViewController)
//
//                 //It removes all view controllers from the navigation controller then sets the new root view controller and it pops.
//                 window?.rootViewController = navigationController
//
//                 //Navigation bar is hidden
//                 navigationController.isNavigationBarHidden = true
//        }
             return true
        }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

