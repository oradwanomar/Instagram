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
    
}
