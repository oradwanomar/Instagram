//
//  ProfileCell.swift
//  Instagram
//
//  Created by Omar Ahmed on 29/05/2022.
//

import UIKit

class ProfileCell : UICollectionViewCell {
    
    //MARK: Properties
    private let postImageView : UIImageView = {
        let piv = UIImageView()
        piv.image = UIImage(named: "venom")
        piv.contentMode = .scaleAspectFill
        piv.clipsToBounds = true
        return piv
    }()
    
    
    //MARK: LifeCycle
    
    override init(frame:CGRect){
        super.init(frame: frame)
        backgroundColor = .systemPink
        addSubview(postImageView)
        postImageView.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Helper
}
