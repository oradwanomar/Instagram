//
//  UserCell.swift
//  Instagram
//
//  Created by Omar Ahmed on 31/05/2022.
//

import UIKit

class UserCell : UITableViewCell {
    
    //MARK: Properities
    
    private let profileimgView : UIImageView = {
        let piv = UIImageView()
        piv.contentMode = .scaleAspectFill
        piv.clipsToBounds = true
        piv.backgroundColor = .lightGray
        piv.image = UIImage(named: "venom")
        return piv
    }()
    
    private let usernameLabel : UILabel = {
        let namelabel = UILabel()
        namelabel.font = UIFont.boldSystemFont(ofSize: 14)
        namelabel.tintColor = .label
        namelabel.text = "omarradwan"
        return namelabel
    }()
    
    private let fullnameLabel : UILabel = {
        let namelabel = UILabel()
        namelabel.font = UIFont.boldSystemFont(ofSize: 14)
        namelabel.tintColor = .lightGray
        namelabel.text = "Omar Radwan"
        return namelabel
    }()
    
    //MARK: LifeCycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUserCell()
        setUpConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Functions
    
    func configureUserCell(){
        addSubview(profileimgView)
    }
    
    func setUpConstrains(){
        profileimgView.setDimensions(height: 50, width: 50)
        profileimgView.layer.cornerRadius = 50 / 2
        profileimgView.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 12)
    }
    
}
