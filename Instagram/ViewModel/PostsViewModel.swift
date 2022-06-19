//
//  PostsViewModel.swift
//  Instagram
//
//  Created by Omar Ahmed on 14/06/2022.
//

import Foundation
import UIKit

class PostsViewModel {
    
    func uploadPost(caption: String,image: UIImage){
        PostService.uploadPost(caption: caption, image: image) { error in
            if let error = error {
                print("Error: Failed to upload post with \(error.localizedDescription)")
            }
        }
    }
    
    
    
}
