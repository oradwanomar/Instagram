//
//  CommentsService.swift
//  Instagram
//
//  Created by Omar Ahmed on 28/06/2022.
//

import Firebase

struct CommentsService {
    
    static func uploadComment(comment: String,postID: String,user: User,completion: @escaping (Error?)->Void){
        
        let data: [String:Any] = ["uid": user.uid,
                                  "comment": comment,
                                  "timestamp": Timestamp(date: Date()),
                                  "username": user.username,
                                  "profileImageUrl": user.profileImageUrl
        ]
        
        COLLECTION_POSTS.document(postID).collection("comments").addDocument(data: data, completion: completion)
        
    }
    
    static func fetchComments(){
        
    }
    
    
}
