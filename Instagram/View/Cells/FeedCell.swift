//
//  FeedCell.swift
//  Instagram
//
//  Created by Omar Ahmed on 19/05/2022.
//

import UIKit
import SDWebImage

protocol FeedCellDelegate: AnyObject{
    func cell(for cell: FeedCell,wantsToShowCommentsFor post: Post)
    func cell(for cell: FeedCell,wantsToLikeFor post: Post)
    func tabUsername(for cell: FeedCell,wantsToShowCommentsFor post: Post)
}

class FeedCell : UICollectionViewCell {
    
    // MARK: Properties
    
    var viewModel: PostsViewModel? {
        didSet {
            configureFeedCell()
        }
    }
    
    weak var delegate: FeedCellDelegate?
    
    private let profileImgView : UIImageView = {
        let piv = UIImageView()
        piv.contentMode = .scaleAspectFill
        piv.clipsToBounds = true
        piv.isUserInteractionEnabled = true
        return piv
    }()
    
    private lazy var usernameButton : UIButton = {
        let btn = UIButton()
        btn.setTitleColor(.label, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        btn.addTarget(self, action: #selector(didTapUsername), for: .touchUpInside)
        return btn
    }()
    
    private let postImgView : UIImageView = {
        let piv = UIImageView()
        piv.contentMode = .scaleAspectFill
        piv.clipsToBounds = true
        piv.isUserInteractionEnabled = true
        piv.image = UIImage(named: "venom")
        return piv
    }()
    
    private lazy var likeButton : UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "like_unselected")?.withTintColor(.label, renderingMode: .alwaysOriginal) , for: .normal)
        btn.tintColor = .black
        btn.addTarget(self, action: #selector(didTapLike), for: .touchUpInside)
        return btn
    }()
    
    private lazy var commentButton : UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "comment")?.withTintColor(.label, renderingMode: .alwaysOriginal) , for: .normal)
        btn.tintColor = .black
        btn.addTarget(self, action: #selector(didTapComment), for: .touchUpInside)
        return btn
    }()
    
    private lazy var shareButton : UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "send2")?.withTintColor(.label, renderingMode: .alwaysOriginal) , for: .normal)
        btn.tintColor = .black
        return btn
    }()
    
    private let likesLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.text = "1 like"
        label.textColor = .label
        return label
    }()
    
    private let captionLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .label
        return label
    }()
    
    private let postTimeLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = .lightGray
        return label
    }()
    
    private let stackView : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    // MARK: Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpCell()
        setUpConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Helper
    
    @objc func didTapLike(){
        guard let viewModel = viewModel else {return}
        self.delegate?.cell(for: self, wantsToLikeFor: viewModel.post)
    }
    
    @objc func didTapComment(){
        guard let viewModel = viewModel else {return}
        self.delegate?.cell(for: self, wantsToShowCommentsFor: viewModel.post)
    }
    
    func configureFeedCell(){
        guard let viewModel = viewModel else {
            return
        }
        captionLabel.text = viewModel.post.caption
        postImgView.sd_setImage(with: URL(string: viewModel.post.imageUrl))
        profileImgView.sd_setImage(with: URL(string: viewModel.post.ownerImageUrl))
        usernameButton.setTitle(viewModel.post.ownerUsername, for: .normal)
        
        if viewModel.post.likes != 1 {
            likesLabel.text = "\(viewModel.post.likes) likes"
        }else{
            likesLabel.text = "\(viewModel.post.likes) like"
        }
    }
    
    func setUpCell(){
        contentView.backgroundColor = .systemBackground
        [profileImgView,usernameButton,postImgView,stackView,likesLabel,captionLabel,postTimeLabel].forEach {addSubview($0)}
        [likeButton,commentButton,shareButton].forEach {
            stackView.addArrangedSubview($0)
        }
    }
    
    func setUpConstrains (){
        profileImgView.anchor(top: topAnchor, left: leftAnchor, paddingTop: 12, paddingLeft: 12, width: 40, height: 40)
        profileImgView.layer.cornerRadius = 20
        
        usernameButton.centerY(inView: profileImgView,leftAnchor: profileImgView.rightAnchor,paddingLeft: 8)
        
        postImgView.anchor(top:profileImgView.bottomAnchor,left: leftAnchor,right: rightAnchor ,paddingTop: 8)
        postImgView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true
        
        stackView.anchor(top:postImgView.bottomAnchor,width: 120,height: 50)
        
        likesLabel.anchor(top:stackView.bottomAnchor,left: leftAnchor,paddingTop: -4 ,paddingLeft: 8)
        captionLabel.anchor(top:likesLabel.bottomAnchor,left: leftAnchor,paddingTop: 7,paddingLeft: 8)
        postTimeLabel.anchor(top:captionLabel.bottomAnchor,left: leftAnchor,paddingTop: 7,paddingLeft: 8)
        
    }
    
    @objc func didTapUsername(){
        guard let viewModel = viewModel else {return}
        self.delegate?.tabUsername(for: self, wantsToShowCommentsFor: viewModel.post)
    }
}
