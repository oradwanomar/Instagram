//
//  ImageUploader.swift
//  Instagram
//
//  Created by Omar Ahmed on 22/05/2022.
//

import FirebaseStorage
import UIKit

struct ImageUploader {
    static func imageUploader(image:UIImage,completion:@escaping (String)->()){
        guard let imageData = image.jpegData(compressionQuality: 0.75) else {return}
        let fileName = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/profile_images/\(fileName)")
        ref.putData(imageData, metadata: nil) { metadata, error in
            if let error = error {
                print("Error : Failed to upload image \(error.localizedDescription)")
                return
            }
            ref.downloadURL { url, error in
                guard let imageUrl = url?.absoluteString else {return}
                completion(imageUrl)
            }
        }
        
    }
}
