//
//  MyAccountViewController.swift
//  Amity
//
//  Created by swapna raddi on 22/05/20.
//  Copyright © 2020 Eneblur Consulting. All rights reserved.
//

import UIKit

class MyAccountViewController: UIViewController {
    
    @IBOutlet weak var myAccountTabelView: UITableView!
    var myProfileArray = ["MY PROFILE","STUDENT WALLET"]
    var myProfileImageArray = ["My Profile","Student Wallet"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
       
        //        // Label clickable
        //            myProfileLabel.isUserInteractionEnabled = true
        //            let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(clickable))
        //            tapGesture.numberOfTouchesRequired = 1
        //            myProfileLabel.addGestureRecognizer(tapGesture)
        //           }
        //
        //        @objc func clickable(){
        //             self.performSegue(withIdentifier: "myProfileSegue", sender: self)
        
    }
    func initialSetup(){
        self.myAccountTabelView.delegate = self
        self.myAccountTabelView.dataSource = self
        self.myAccountTabelView.register(UINib(nibName: "MyAccountTableViewCell", bundle: nil), forCellReuseIdentifier: "MyAccountTableViewCell")
        
    }
    @IBAction func onBackButtonPressed(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func buttonSignOut(_ sender: Any) {
        
        callSignout()
    }
    
    // Call SignOut API
    func callSignout(){
        
        let userUrl = "http://35.165.245.142:8080/authentication/logout"
        // Add one parameter
        let myUrl = NSURL(string: userUrl)
        
        // Creaste URL Request
        let request = NSMutableURLRequest(url:myUrl! as URL)
        request.httpMethod = "GET"
        request.setValue(UserDefaults.standard.string(forKey: "USER"), forHTTPHeaderField: "Cookie")
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            guard error == nil && data != nil else {      // check for fundamental networking error
                print("error=\(String(describing: error))")
                return
            }
            do {
                
                if let responseJSON = try JSONSerialization.jsonObject(with: data!) as? [String:AnyObject]{
                    print(responseJSON)
                }
            }
                
            catch {
                print("Error -> \(error)")
            }
        }
        task.resume()
    }
}
extension MyAccountViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myProfileArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let myAccountTableViewCell = self.myAccountTabelView.dequeueReusableCell(withIdentifier: "MyAccountTableViewCell", for: indexPath) as? MyAccountTableViewCell {
            
            myAccountTableViewCell.profileLabel.text = myProfileArray[indexPath.row]
            myAccountTableViewCell.profileImage.image = UIImage(named : myProfileImageArray[indexPath.item])
            return myAccountTableViewCell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        if indexPath.row == 0 {
           // self.performSegue(withIdentifier: "myAccountToProfileSegue", sender: self)
           // let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            if let myProfileViewController = self.storyboard?.instantiateViewController(withIdentifier: "MyProfileViewController1") as? MyProfileViewController1 {
                          self.navigationController?.pushViewController(myProfileViewController, animated: true)
                           }
        } else if indexPath.row == 1 {
            
        }
               
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}



