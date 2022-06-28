//
//  Comment.swift
//  Instagram
//
//  Created by Omar Ahmed on 28/06/2022.
//

import Firebase

struct Comment {
    let uid: String
    let commentText: String
    let timestamp: Timestamp
    let username: String
    let profileImageUrl: String
    
    
    init(dictionary: [String:Any]){
        self.uid = dictionary["uid"] as? String ?? ""
        self.commentText = dictionary["comment"] as? String ?? ""
        self.timestamp = dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())
        self.username = dictionary["username"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
    }
}
