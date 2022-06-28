//
//  CommentCell.swift
//  Instagram
//
//  Created by Omar Ahmed on 26/06/2022.
//

import UIKit

class CommentCell: UICollectionViewCell {
    
    //MARK: Properities
    
    var commentViewModel: CommentsViewModel? {
        didSet {
            configureCommentVM()
        }
    }
    
    private let userProfileImage: UIImageView = {
        let pImg = UIImageView()
        pImg.backgroundColor = .lightGray
        pImg.clipsToBounds = true
        pImg.contentMode = .scaleToFill
        pImg.layer.cornerRadius = 40 / 2
        return pImg
    }()
    
    private let commentLabel = UILabel()
    
    
    
    //MARK: LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
        setupConstrains()
    }
    
    func configureCell(){
        backgroundColor = .systemBackground
        addSubview(userProfileImage)
        addSubview(commentLabel)
    }
    
    func setupConstrains(){
        userProfileImage.centerY(inView: self,leftAnchor: leftAnchor,paddingLeft: 8)
        userProfileImage.setDimensions(height: 40, width: 40)
        
        commentLabel.centerY(inView: self,leftAnchor: userProfileImage.rightAnchor,paddingLeft: 8)
    }
    
    func configureCommentVM(){
        guard let commentViewModel = commentViewModel else { return }
        userProfileImage.sd_setImage(with: commentViewModel.userProfileImgUrl)
        commentLabel.attributedText = commentLabelText(username: commentViewModel.commentUsername, commentLabel: commentViewModel.commentText)
    }
    
    func commentLabelText(username: String,commentLabel: String)-> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: "\(username) ", attributes: [.font:UIFont.boldSystemFont(ofSize: 14),.foregroundColor: UIColor.label])
        attributedString.append(NSAttributedString(string: "\(commentLabel)", attributes: [.font:UIFont.systemFont(ofSize: 13),.foregroundColor: UIColor.label]))
        return attributedString
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
