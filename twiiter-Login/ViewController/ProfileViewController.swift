//
//  ProfileViewController.swift
//  twiiter-Login
//
//  Created by Mehul on 17/06/21.
//

import UIKit
import TwitterKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var profileNameLabel: UILabel!
    
    @IBOutlet weak var emailAddressLabel: UILabel!
    
    @IBOutlet weak var FollowersButton: UIButton!
    
    @IBOutlet weak var FollowingButton: UIButton!
    
    
    var profileData : UserProfile? = nil
    var email = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        UISetUP()
        SetData()
        
    }
    
    func UISetUP()
    {
        profileImageView.layer.borderWidth = 1.0
        profileImageView.layer.masksToBounds = false
        profileImageView.layer.borderColor = UIColor.black.cgColor
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2
        profileImageView.clipsToBounds = true
    }
    
    func SetData()
    {
        profileNameLabel.text = profileData?.name
        FollowersButton.setTitle("\(profileData?.followersCount ?? 0) Followers", for: .normal)
        FollowingButton.setTitle("\(profileData?.friendsCount ?? 0) Friends", for: .normal)
        
        let url = URL(string: profileData!.profileImageURL)

        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                self.profileImageView.image = UIImage(data: data!)
            }
        }
    }
    
    @IBAction func FollowingButtonAction(_ sender: Any) {
        
        let next = self.storyboard?.instantiateViewController(withIdentifier: "FriendListViewController") as! FriendListViewController
        self.present(next, animated: true, completion: nil)
    }
    
    @IBAction func logoutButtonAction(_ sender: Any) {
        
        let logout = TWTRTwitter.sharedInstance().sessionStore
        if let userID = logout.session()?.userID {
            print(logout.session()?.userID ?? "")
            logout.logOutUserID(userID)
            print(logout.session()?.userID ?? "")
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
}
