//
//  File.swift
//  twiiter-Login
//
//  Created by Mehul on 17/06/21.
//

import UIKit

extension FriendListViewController : UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let friendList = dataController.friendList, friendList.count > 0
        {
            return friendList.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let friendList = dataController.friendList
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) 
                                                          
            cell.textLabel?.text = friendList[indexPath.row].name
            
            let url = URL(string:friendList[indexPath.row].imageUrl )
            let data = try? Data(contentsOf: url!)
            cell.imageView?.image = UIImage(data: data!)
            
            return cell
        }
        else
        {
            return UITableViewCell()
        }
    }
}
