//
//  CommentCell.swift
//  Instagram
//
//  Created by Omar Ahmed on 26/06/2022.
//

import UIKit

class CommentCell: UICollectionViewCell {
    
    //MARK: Properities
    
    
    
    //MARK: LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .secondaryLabel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
