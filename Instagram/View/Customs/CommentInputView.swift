//
//  CommentInputView.swift
//  Instagram
//
//  Created by Omar Ahmed on 26/06/2022.
//

import UIKit

protocol CommentInputViewDelegate: AnyObject {
    func inputVIew(_ view:CommentInputView,comment: String)
}

class CommentInputView: UIView {
    
    //MARK: Properities
    
    weak var delegate: CommentInputViewDelegate?
    
    private let commentTextView: CaptionTextView = {
        let tv = CaptionTextView()
        tv.isScrollEnabled = false
        tv.placeholderText = "Add a comment.."
        tv.font = UIFont.systemFont(ofSize: 15)
        tv.placeholderShouldCenter = true
        return tv
    }()
    
    private let postBtn: UIButton = {
        let pBtn = UIButton(type: .system)
        pBtn.setTitle("Post", for: .normal)
        pBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        pBtn.setTitleColor(.label, for: .normal)
        pBtn.addTarget(self, action: #selector(handlePostComment), for: .touchUpInside)
        return pBtn
    }()
    
    //MARK: LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        setupConstrains()
    }
    
    func configureUI(){
        backgroundColor = .systemBackground
        autoresizingMask = .flexibleHeight
        addSubview(commentTextView)
        addSubview(postBtn)
    }
    
    func setupConstrains(){
        postBtn.anchor(top: topAnchor,right:rightAnchor,paddingRight: 8)
        postBtn.setDimensions(height: 50, width: 50)
        
        commentTextView.anchor(top: topAnchor,left: leftAnchor,bottom: safeAreaLayoutGuide.bottomAnchor,right: postBtn.leftAnchor,paddingTop: 8,paddingLeft: 8,paddingBottom: 8,paddingRight: 8)
        
        let divider = UIView(frame: .zero)
        divider.backgroundColor = .lightGray
        addSubview(divider)
        divider.anchor(top: topAnchor,left: leftAnchor,right: rightAnchor,height: 0.5)
    }
    
    @objc func handlePostComment(){
        self.delegate?.inputVIew(self, comment: commentTextView.text)
    }
    
    func clearTextAfterPost(){
        commentTextView.text = nil
        commentTextView.placeholder.isHidden = false
    }
    
    override var intrinsicContentSize: CGSize {
        return .zero
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
