//
//  StudentwalletdetailsViewController.swift
//  Amity
//
//  Created by Snehalatha Desai on 29/07/20.
//  Copyright © 2020 Eneblur Consulting. All rights reserved.
//

import UIKit

class StudentwalletdetailsViewController: UIViewController {

    
    @IBOutlet weak var  dispname : UILabel!
     @IBOutlet weak var  facname : UILabel!
     @IBOutlet weak var  imageview : UIImageView!
    
    var titlename = String()
    var imageurl = String()
    var facultyname = String()
   
    
    
    @IBAction func print_btn(_ sender : UIButton)
    {
        
    }
    @IBAction func download_btn(_ sender : UIButton)
    {
        let url = URL(string: imageurl)!
        downloadImage(from: url)
    }
    @IBAction func share_btn(_ sender : UIButton)
    {
        
    }
    @IBAction func attach_btn(_ sender : UIButton)
    {
        
    }
    
    @IBAction func send_btn(_ sender : UIButton)
    {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dispname.text = titlename
        facname.text = facultyname
        print("imageurl:",imageurl)
        imageview.imageFromServer(urlString: imageurl)
        
        // Do any additional setup after loading the view.
    }
    
    func downloadImage(from url: URL) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() { [weak self] in
                self?.imageview.image = UIImage(data: data)
            }
        }
    }
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
