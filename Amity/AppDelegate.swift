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
        let loginStatus = UserDefaults.standard.bool(forKey: "IsLoggedIn")
        if loginStatus{
            self.screenNavigation()
        }
        navigationBarSetUp()
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
    func screenNavigation(){
                let viewController = Storyboard.Main.instance.instantiateViewController(withIdentifier: "tabBarViewController") as! UITabBarController
        
           //window?.makeKeyAndVisible()
         window?.rootViewController = viewController
        //
       
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "ExperiencePageViewController") as? ExperiencePageViewController
//        UIApplication.shared.keyWindow?.rootViewController = vc
//        
        
//        let loginStoryboard = Storyboard.Main.instance
//        if let navigationController = loginStoryboard.instantiateViewController(withIdentifier:"NavigationViewController") as? UINavigationController {
//
//            let enterPinViewController = loginStoryboard.instantiateViewController(withIdentifier: "HomePage1ViewController")
//            navigationController.pushViewController(enterPinViewController, animated: false)
//            self.window?.rootViewController = navigationController
//        }
        
    }
    
    
    func navigationBarSetUp(){
        let navigationBarAppearace = UINavigationBar.appearance()
        navigationBarAppearace.tintColor = UIColor.white
        navigationBarAppearace.barTintColor = UIColor(named: "DarkBlueColour")
        navigationBarAppearace.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
    }
    
}

