//
//  ProfileCell.swift
//  Instagram
//
//  Created by Omar Ahmed on 29/05/2022.
//

import UIKit

class ProfileCell : UICollectionViewCell {
    
    //MARK: Properties
    
    
    //MARK: LifeCycle
    
    override init(frame:CGRect){
        super.init(frame: frame)
        backgroundColor = .systemPink
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Helper
}
