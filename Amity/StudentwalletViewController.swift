//
//  StudentwalletViewController.swift
//  Amity
//
//  Created by Snehalatha Desai on 21/07/20.
//  Copyright © 2020 Eneblur Consulting. All rights reserved.
//

import UIKit
import Alamofire
class StudentwalletViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return docdata.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier:"StudentWalletTableViewCell" ) as! StudentWalletTableViewCell
        let data = docdata[indexPath.row]
        cell.titlelabel.text = data.docname
        
                   return cell
        
        
    }
    

     @IBOutlet weak var tableView: UITableView!
    
    var docdata = [studentwallet]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
               tableView.dataSource = self
             
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        getstudentwalletAPI()
        self.tableView.reloadData()
        
    }
    
    func getstudentwalletAPI(){
                 
                
                 
            print("url :",GET_STUDENTWALLET_API)
                 if isInternetAvailable(){
                   Util.Manager.request(GET_STUDENTWALLET_API, method : .get, encoding: JSONEncoding.default).responseJSON { (response) in
                         switch response.result{
                         case .success(_):
                             if let json = response.result.value{
                                 if let jsonData = json as? NSDictionary {
                                     if let status = jsonData.object(forKey: "status") as? Int {
                                         
                                       if status == 200
                                       {
                                        print("response here",jsonData)
//                                        let path = Bundle.main.path(forResource: "filename", ofType: "json")
//                                           let jsonData2 = try? NSData(contentsOfFile: path!, options: NSData.ReadingOptions.mappedIfSafe)
                                    guard let path = Bundle.main.path(forResource: "samplejson", ofType: "json") else { return }

                                        let url = URL(fileURLWithPath: path)

                                       
                                            let datas = try? Data(contentsOf: url)

                                        let jsonnew = try? JSONSerialization.jsonObject(with: datas!, options: .fragmentsAllowed)

                                          if let jsonDatanew = jsonnew as? NSDictionary {
                                        if let data = jsonDatanew.object(forKey: "data") as? NSDictionary{
//                                                                          for exp in data {
                                                                              
//                                                                              let i = exp as! NSDictionary
                                                                              let stud = studentwallet()
                                                                            if let docdetails = data.object(forKey: "documentDetails") as? NSArray{
                                                                                        
                                                                                for fac in docdetails
                                                                                {
                                                                                                                                  let i = fac as! NSDictionary
                                                                                          if let degree = i.object(forKey: "degreeId") as? NSDictionary{
                                                                                            
                                                                                               
                                                                                                stud.docname = degree.value(forKey: "displayName") as? String
                                                                                            
                                                                                            
                                                                                    }
                                                                                    
                                                                                    
                                                                                                                                stud.docidentity = i.value(forKey: "documentIdentity") as? String
                                                                                                                                 self.docdata.append(stud)
                                                                                }
                                                                               
                                                                            }
                                                                            

                                                                            
                                                                             

                                                                         }
                                        }
                                       }
                                        else if status == 401
                                       {
                                        print("sigin again")
                                        self.callSignout()
                                        }
                                     }
                                 }
                             }
                    self.tableView.reloadData()
                             break
                         case .failure(_):
                             if let statusCode = response.response?.statusCode {
                                 
                             }
                             break
                             
                         }
                     }
                 } else {
                     //Util.showWhistle(message: NO_INTERNET, viewController: CourseViewController.self)
                 }
        }
    
    
    
    
    
    func callSignout(){
            
            startActivityIndicator()
            let userUrl = LOGOUT_API
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
                    DispatchQueue.main.async {
                         self.stopActivityIndicator()
                    }
                   
                    if let responseJSON = try JSONSerialization.jsonObject(with: data!) as? [String:AnyObject]{
                        let status = responseJSON["status"] as? Int
                        if status == 200 {
                            DispatchQueue.main.async {
                                 if let signInViewController = Storyboard.Main.instance.instantiateViewController(withIdentifier: "SignInVC") as? SignInViewController {
                                                           
                                    UserDefaults.standard.set(false, forKey: "IsLoggedIn")
                                     let domain = Bundle.main.bundleIdentifier!
                                      UserDefaults.standard.removePersistentDomain(forName: domain)
                                      UserDefaults.standard.synchronize()
                                      print(Array(UserDefaults.standard.dictionaryRepresentation().keys).count)
                                     signInViewController.hidesBottomBarWhenPushed = true
                                     self.navigationController?.pushViewController(signInViewController, animated: false)
                            }
                           
                            }
                        }
                    }
                }
                    
                catch {
                    print("Error -> \(error)")
                }
            }
            task.resume()
        }
    }
    
    
    
    
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


