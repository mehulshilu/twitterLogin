//
//  Model.swift
//  twiiter-Login
//
//  Created by Mehul on 17/06/21.
//

import Foundation

struct UserProfile {
    let name: String
    let profileImageURL: String
    let followersCount : Int
    let friendsCount : Int
  
  init?(dictionary: [String: Any]) {

    guard let name = dictionary["name"] as? String else { return nil }
    guard let profileImageURL = dictionary["profile_image_url_https"] as? String else { return nil }
    guard let followersCount = dictionary["followers_count"] as? Int else { return nil }
    guard let friendsCount = dictionary["friends_count"] as? Int else { return nil }
    
    
    self.name = name
    self.profileImageURL = profileImageURL
    self.followersCount = followersCount
    self.friendsCount = friendsCount
    
  }
}


struct FriendData
{
    let name : String
    let imageUrl: String
    
    init?(dictionary: [String: Any]) {

      guard let name = dictionary["name"] as? String else { return nil }
      guard let profileImageURL = dictionary["profile_image_url_https"] as? String else { return nil }
      
      self.name = name
      self.imageUrl = profileImageURL
      
}
}
