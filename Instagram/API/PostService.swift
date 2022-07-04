//
//  PostService.swift
//  Instagram
//
//  Created by Omar Ahmed on 15/06/2022.
//

import Foundation
import Firebase
import UIKit

struct PostService {
    
    static func uploadPost(caption: String,user: User,image: UIImage, completion: @escaping (Error?)->Void){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        ImageUploader.imageUploader(image: image) { imageURL in
            let data = ["caption": caption,
                        "timestamp": Timestamp(date: Date()),
                        "likes": 0,
                        "imageUrl": imageURL,
                        "currentUid": uid,
                        "ownerImageUrl": user.profileImageUrl,
                        "ownerUsername": user.username] as [String:Any]
            COLLECTION_POSTS.addDocument(data: data, completion: completion)
        }
    }
    
    static func fetchPosts(completion: @escaping ([Post])->()){
        var posts : [Post] = []
        COLLECTION_POSTS.order(by: "timestamp", descending: true).getDocuments { snapshot, error in
            guard let documents = snapshot?.documents else {return}
            documents.forEach { doc in
                let post = Post(postId: doc.documentID, dictionary: doc.data())
                posts.append(post)
            }
            completion(posts)
        }
    }
    
    static func fetchUserPosts(uid: String,completion: @escaping ([Post])->()){
       let query =  COLLECTION_POSTS.whereField("currentUid", isEqualTo: uid)
        query.getDocuments { snapshot, error in
            guard let snapshot = snapshot?.documents else {return}
            var posts = snapshot.map({Post(postId: $0.documentID, dictionary: $0.data())})
            posts.sort { $0.timestamp.seconds > $1.timestamp.seconds }
            completion(posts)
        }
    }
    
    static func likePost(post: Post,completion: @escaping (Error?)->Void){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        COLLECTION_POSTS.document(post.postId).updateData(["Likes" : post.likes + 1])
        
        COLLECTION_POSTS.document(post.postId).collection("post-Likes").document(uid).setData([:]) { _ in
            
            COLLECTION_USERS.document(uid).collection("user-Likes").document(post.postId).setData([:], completion: completion)
        }
    }
    
    static func unlikePost(post: Post,completion: @escaping (Error?)->Void){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        COLLECTION_POSTS.document(post.postId).updateData(["Likes" : post.likes - 1])
        
        COLLECTION_POSTS.document(post.postId).collection("post-Likes").document(uid).delete { _ in
            
            COLLECTION_USERS.document(uid).collection("user-Likes").document(post.postId).delete(completion: completion)

        }
    }
    
}
