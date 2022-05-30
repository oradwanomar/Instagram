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
    
    private lazy var editProfileFollowBtn : UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Edit Profile", for: .normal)
        btn.layer.cornerRadius = 3
        btn.layer.borderColor = UIColor.lightGray.cgColor
        btn.layer.borderWidth = 0.4
        btn.backgroundColor = .systemBackground
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        btn.setTitleColor(.label, for: .normal)
        btn.addTarget(self, action: #selector(handleEditProfileFollowTap), for: .touchUpInside)
        return btn
    }()
    
    private lazy var postsLabel : UILabel = {
        let plabel = UILabel()
        plabel.numberOfLines = 0
        plabel.textAlignment = .center
        plabel.attributedText = setProfileAttributedTexts(value: 23, label: "Posts")
        return plabel
    }()
    
    private lazy var followersLabel : UILabel = {
        let plabel = UILabel()
        plabel.numberOfLines = 0
        plabel.textAlignment = .center
        plabel.attributedText = setProfileAttributedTexts(value: 8, label: "Followers")
        return plabel
    }()
    
    private lazy var followingLabel : UILabel = {
        let plabel = UILabel()
        plabel.numberOfLines = 0
        plabel.textAlignment = .center
        plabel.attributedText = setProfileAttributedTexts(value: 9, label: "Following")
        return plabel
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
        addSubview(editProfileFollowBtn)
        let stackView = UIStackView(arrangedSubviews: [postsLabel,followersLabel,followingLabel])
        stackView.distribution = .fillEqually
        addSubview(stackView)
        stackView.centerX(inView: profileImageView)
        stackView.anchor(left:profileImageView.rightAnchor,right: rightAnchor,paddingLeft: 12,paddingRight: 12,height: 50)
    }
    
    func setUpConstrains(){
        profileImageView.anchor(top: topAnchor,left: leftAnchor,paddingTop: 16,paddingLeft: 16)
        profileImageView.setDimensions(height: 80, width: 80)
        profileImageView.layer.cornerRadius = 40
        
        nameUser.anchor(top:profileImageView.bottomAnchor,left: leftAnchor,paddingTop: 12,paddingLeft: 12)
        
        editProfileFollowBtn.anchor(top:nameUser.bottomAnchor,left:leftAnchor,right: rightAnchor,paddingTop: 16,paddingLeft: 24,paddingRight: 24)
        
    }
    
    func setProfileAttributedTexts(value : Int,label : String) -> NSAttributedString {
        let attributedText = NSMutableAttributedString(string: "\(value)", attributes: [.font : UIFont.boldSystemFont(ofSize: 14)])
        attributedText.append(NSAttributedString(string: label, attributes: [.font:UIFont.boldSystemFont(ofSize: 14),.foregroundColor:UIColor.lightGray]))
        return attributedText
    }
    
    @objc func handleEditProfileFollowTap(){}
}
