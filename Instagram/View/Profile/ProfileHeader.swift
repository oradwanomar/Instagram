//
//  ProfileHeader.swift
//  Instagram
//
//  Created by Omar Ahmed on 29/05/2022.
//

import UIKit

class ProfileHeader : UICollectionReusableView {
    
    //MARK: Properties
    private let profileImageView : UIImageView = {
        let piv = UIImageView()
        piv.image = UIImage(named: "venom")
        piv.contentMode = .scaleAspectFill
        piv.clipsToBounds = true
        return piv
    }()
    
    private let nameUser : UILabel = {
        let name = UILabel()
        name.font = UIFont.boldSystemFont(ofSize: 14)
        name.text = "Omar Radwan"
        return name
    }()
    
    //MARK: LifeCycle
    
    override init(frame:CGRect){
        super.init(frame: frame)
        backgroundColor = .systemBackground
        configureProfileHeader()
        setUpConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Helper
    
    func configureProfileHeader(){
        addSubview(profileImageView)
        addSubview(nameUser)
    }
    
    func setUpConstrains(){
        profileImageView.anchor(top: topAnchor,left: leftAnchor,paddingTop: 16,paddingLeft: 16)
        profileImageView.setDimensions(height: 80, width: 80)
        profileImageView.layer.cornerRadius = 40
        
        nameUser.anchor(top:profileImageView.bottomAnchor,left: leftAnchor,paddingTop: 12,paddingLeft: 12)

    }
}
