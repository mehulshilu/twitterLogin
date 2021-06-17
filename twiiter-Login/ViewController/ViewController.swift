//
//  ViewController.swift
//  twiiter-Login
//
//  Created by Mehul on 17/06/21.
//

import UIKit
import TwitterKit

class ViewController: UIViewController {

    @IBOutlet weak var twitterButton: UIButton!
    
    let dataController : DataController = DataController()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        dataController.delegate = self
    }

    @IBAction func twitterButtonAction(_ sender: Any)
    {
       dataController.Login()

    }
    
    
}
extension ViewController : loginDelegate
{
    func success(userData : UserProfile, email : String)
    {
        let next = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        next.profileData = userData
        next.email = email
        self.present(next, animated: true, completion: nil)
    }
    
    
}

