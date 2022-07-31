//
//  CommentsViewModel.swift
//  Instagram
//
//  Created by Omar Ahmed on 28/06/2022.
//

import Foundation
import UIKit


class CommentsViewModel {
    let comment: Comment
    
    var commentText: String {
        return comment.commentText
    }
    
    var commentUsername: String {
        return comment.username
    }
    
    var userProfileImgUrl: URL? {
        return URL(string: comment.profileImageUrl)
    }
    
    init(comment: Comment){
        self.comment = comment
    }
    
    func size(forWidth width: CGFloat) -> CGSize {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = commentText
        label.lineBreakMode = .byCharWrapping
        label.setWidth(width)
        return label.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
    }
    
}
