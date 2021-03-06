//
//  CommentsController.swift
//  Instagram
//
//  Created by Omar Ahmed on 26/06/2022.
//

import UIKit

private let reuseIdentifier = "CommentsCell"

class CommentsController: UICollectionViewController {
    
    //MARK: properities
    
    private let post: Post
    var comments: [Comment] = []
    
    private lazy var commentView: CommentInputView = {
        let frame  = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        let cv = CommentInputView(frame: frame)
        cv.delegate = self
        return cv
    }()
    
    //MARK: lifeCycle
    
    init(post: Post) {
        self.post = post
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        fetchComments()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override var inputAccessoryView: UIView? {
        get {return commentView}
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    
    // MARK: Helper Functions
    
    func configureCollectionView(){
        title = "Comments"
        collectionView.backgroundColor = .systemBackground
        collectionView.register(CommentCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.alwaysBounceVertical = true
        collectionView.keyboardDismissMode = .interactive
    }
    
    func fetchComments(){
        CommentsService.fetchComments(forPost: post.postId) { comments in
            self.comments = comments
            self.collectionView.reloadData()
        }
    }


}

// MARK: UICollectionViewDataSource

extension CommentsController {

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return comments.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CommentCell
        cell.commentViewModel = CommentsViewModel(comment: comments[indexPath.row])
        return cell
    }
}

// MARK: UICollectionViewDelegate

extension CommentsController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let uid = comments[indexPath.row].uid
        UserService.fetchUser(forUserID: uid) { user in
            let profileVC = ProfileController(user: user)
            self.navigationController?.pushViewController(profileVC, animated: true)
        }
    }
    
}

//MARK: UICollectionViewDelegateFlowLayout

extension CommentsController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let viewModel = CommentsViewModel(comment: comments[indexPath.row])
        let height = viewModel.size(forWidth: view.frame.width).height + 32
        return CGSize(width: view.frame.width, height: height)
    }
}

//MARK: CommentInputViewDelegate

extension CommentsController: CommentInputViewDelegate {
    func inputVIew(_ view: CommentInputView, comment: String) {
        
        guard let tabBar = self.tabBarController as? MainTabBarController else {return}
        
        guard let user = tabBar.user else {return}
        
        showLoader(true)
        
        CommentsService.uploadComment(comment: comment, postID: post.postId, user: user) { error in
            self.showLoader(false)
            view.clearTextAfterPost()
        }
    }
}
