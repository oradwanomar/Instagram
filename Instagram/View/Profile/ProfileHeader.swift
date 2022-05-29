//
//  ProfileHeader.swift
//  Instagram
//
//  Created by Omar Ahmed on 29/05/2022.
//

import UIKit

class ProfileHeader : UICollectionReusableView {
    
    //MARK: Properties
    
    
    //MARK: LifeCycle
    
    override init(frame:CGRect){
        super.init(frame: frame)
        backgroundColor = .blue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Helper
}
