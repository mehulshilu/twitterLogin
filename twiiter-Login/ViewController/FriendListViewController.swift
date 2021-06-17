//
//  FreindListViewController.swift
//  twiiter-Login
//
//  Created by Mehul on 17/06/21.
//

import UIKit

class FriendListViewController: UIViewController {

    @IBOutlet weak var listTableView: UITableView!
        
        
    let cellReuseIdentifier = "cell"
    
    let dataController : DataController = DataController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        dataController.delegate = self
        
        tableViewCellSetup()
        
        getFriendData()
        
    }
    
    func tableViewCellSetup()
    {
        self.listTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
    }
    
    func getFriendData()
    {
        dataController.getFriendListData(count: 10)
    }
    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
extension FriendListViewController : loginDelegate
{
    func SuccessReloadTableView()
    {
        //Success Data
        //Reload Tableview
        
    }
    

}
