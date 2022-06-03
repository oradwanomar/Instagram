//
//  ProfileHeader.swift
//  Instagram
//
//  Created by Omar Ahmed on 29/05/2022.
//

import UIKit
import SDWebImage

class ProfileHeader : UICollectionReusableView {
    
    //MARK: Properties
    
    var phViewModel : ProfileViewModel? {
        didSet {configureViewModel()}
    }
    
    
    private let profileImageView : UIImageView = {
        let piv = UIImageView()
        piv.contentMode = .scaleAspectFill
        piv.clipsToBounds = true
        piv.backgroundColor = .lightGray
        return piv
    }()
    
    private let nameUser : UILabel = {
        let name = UILabel()
        name.font = UIFont.boldSystemFont(ofSize: 14)
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
    
    let gridButton : UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "grid"), for: .normal)
        return btn
    }()
    
    let listButton : UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "list"), for: .normal)
        btn.tintColor = UIColor(white: 0, alpha: 0.2)
        return btn
    }()
    
    let bookMarkButton : UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "ribbon"), for: .normal)
        btn.tintColor = UIColor(white: 0, alpha: 0.2)
        return btn
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
        stackView.centerY(inView: profileImageView)
        stackView.anchor(left:profileImageView.rightAnchor,right: rightAnchor,paddingLeft: 12,paddingRight: 12,height: 50)
        
        let topDivider = UIView()
        topDivider.backgroundColor = .lightGray
        
        let bottomDivider = UIView()
        bottomDivider.backgroundColor = .lightGray
        
        let buttonsStack = UIStackView(arrangedSubviews: [gridButton,listButton,bookMarkButton])
        buttonsStack.distribution = .fillEqually
        
        addSubview(topDivider)
        addSubview(bottomDivider)
        addSubview(buttonsStack)
        
        buttonsStack.anchor(left:leftAnchor,bottom: bottomAnchor,right: rightAnchor,height: 50)
        
        topDivider.anchor(top:buttonsStack.topAnchor,left:leftAnchor,right: rightAnchor,height: 0.5)
        
        bottomDivider.anchor(top:buttonsStack.bottomAnchor,left:leftAnchor,right: rightAnchor,height: 0.5)
        
    }
    
    func setUpConstrains(){
        profileImageView.anchor(top: topAnchor,left: leftAnchor,paddingTop: 16,paddingLeft: 16)
        profileImageView.setDimensions(height: 80, width: 80)
        profileImageView.layer.cornerRadius = 40
        
        nameUser.anchor(top:profileImageView.bottomAnchor,left: leftAnchor,paddingTop: 12,paddingLeft: 24)
        
        editProfileFollowBtn.anchor(top:nameUser.bottomAnchor,left:leftAnchor,right: rightAnchor,paddingTop: 16,paddingLeft: 24,paddingRight: 24)
        
    }
    
    func setProfileAttributedTexts(value : Int,label : String) -> NSAttributedString {
        let attributedText = NSMutableAttributedString(string: "\(value)\n", attributes: [.font : UIFont.boldSystemFont(ofSize: 14)])
        attributedText.append(NSAttributedString(string: label, attributes: [.font:UIFont.boldSystemFont(ofSize: 14),.foregroundColor:UIColor.lightGray]))
        return attributedText
    }
    
    func configureViewModel(){
        guard let phViewModel = phViewModel else {
            return
        }
        profileImageView.sd_setImage(with: phViewModel.profileImageUrl, completed: nil)
        nameUser.text = phViewModel.fullname
        editProfileFollowBtn.setTitle(phViewModel.followButtonText, for: .normal)
    }
    
    @objc func handleEditProfileFollowTap(){}
}
