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
    
    static func uploadPost(caption: String,image: UIImage, completion: @escaping (Error?)->Void){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        ImageUploader.imageUploader(image: image) { imageURL in
            let data = ["caption": caption,
                        "timestamp": Timestamp(date: Date()),
                        "likes": 0,
                        "imageUrl": imageURL,
                        "currentUid": uid ] as [String:Any]
            COLLECTION_POSTS.addDocument(data: data, completion: completion)
        }
        
    } 
    
    static func fetchPosts(){
        
    }
    
}
