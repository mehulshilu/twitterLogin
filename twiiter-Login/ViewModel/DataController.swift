//
//  DataController.swift
//  twiiter-Login
//
//  Created by Mehul on 17/06/21.
//

import Foundation
import TwitterKit

protocol loginDelegate {
    func success(userData : UserProfile, email : String)
    func SuccessReloadTableView()
}

extension loginDelegate{
    func success(userData : UserProfile, email : String) {}
    func SuccessReloadTableView(){}
    
}

class DataController: NSObject
{
    var userData : UserProfile?
    var delegate : loginDelegate?
    var email : String?
    var screenName : String?
    var userID : String?
    var friendList : [FriendData]?
    
    func Login()
    {
        TWTRTwitter.sharedInstance().logIn { (session, error) in
                if (session != nil) {
                    let name = session?.userName ?? ""
                    print(name)
                    print(session?.userID  ?? "")
                    print(session?.authToken  ?? "")
                    print(session?.authTokenSecret  ?? "")
                    let client = TWTRAPIClient.withCurrentUser()
                    client.requestEmail { email, error in
                        if (email != nil) {
                            let recivedEmailID = email ?? ""
                            print(recivedEmailID)
                        }else {
                            print("error--: \(String(describing: error?.localizedDescription))");
                        }
                    }
                    
                    self.userID = session?.userID
                
                    
                    //To get profile image url and screen name
                    let twitterClient = TWTRAPIClient(userID: session?.userID)
                        twitterClient.loadUser(withID: session?.userID ?? "") {(user, error) in
                            var emaiID = String()
                            
                            twitterClient.requestEmail { email, error in
                                if (email != nil) {
                                    emaiID = email ?? ""
                                    self.email = email ?? ""
                                    print(email)
                                }else {
                                    print("error--: \(String(describing: error?.localizedDescription))");
                                }
                            }
                            
                            self.screenName = user?.screenName

                            self.getUserInfo(screenName: user!.screenName, userId: session!.userID, emailId : emaiID)
                    }
                
                    }else {
                        print("error: \(String(describing: error?.localizedDescription))");
                    }
                }
    }
    
    func getUserInfo(screenName : String, userId : String, emailId : String){
      
            let client = TWTRAPIClient(userID: userId)
            let url = "https://api.twitter.com/1.1/users/show.json"
            let params = ["screen_name": screenName]
            var clientError : NSError?
            let request = client.urlRequest(withMethod: "GET", urlString: url, parameters: params, error: &clientError)
        
            client.sendTwitterRequest(request) { (response, data, connectionError) -> Void in
           
                    guard let responseData = data else {return}
                    do {
                         if let userDictionary = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: Any] {
                            
                          let user = UserProfile(dictionary: userDictionary)
                            self.userData = user
                            print(self.userData)
                            
                            self.delegate?.success(userData: user!, email: emailId)
                        }

                    } catch let jsonError {
                        print("error: \(jsonError)");
                    }
            }
    }
    
    
    func getFriendListData(count : Int)
    {
        let client = TWTRAPIClient(userID: userID)
        let url = "https://api.twitter.com/1.1/friends/list.json"
        let countlist = count
        
        let params = ["screen_name": self.screenName!, "count" : countlist] as [String : Any]
        var clientError : NSError?
        let request = client.urlRequest(withMethod: "GET", urlString: url, parameters: params, error: &clientError)
    
        client.sendTwitterRequest(request) { (response, data, connectionError) -> Void in
       
                guard let responseData = data else {return}
                do {
                     if let userDictionary = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: Any] {
                        //Data will be mapped here add to Array friendList

                        self.delegate?.SuccessReloadTableView()
                    }

                } catch let jsonError {
                    print("error: \(jsonError)");
                }
        }
        
    }
}
