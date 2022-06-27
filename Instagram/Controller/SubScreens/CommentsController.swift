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
    
    private lazy var commentView: CommentInputView = {
        let frame  = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        let cv = CommentInputView(frame: frame)
        cv.delegate = self
        return cv
    }()
    
    //MARK: lifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
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
    
    func configureCollectionView(){
        title = "Comments"
        collectionView.backgroundColor = .systemBackground
        collectionView.register(CommentCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.alwaysBounceVertical = true
        collectionView.keyboardDismissMode = .interactive
    }


}

// MARK: UICollectionViewDataSource

extension CommentsController {

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CommentCell
        return cell
    }
}

// MARK: UICollectionViewDelegate

extension CommentsController {
    
}

//MARK: UICollectionViewDelegateFlowLayout

extension CommentsController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 80)
    }
}

//MARK: CommentInputViewDelegate

extension CommentsController: CommentInputViewDelegate {
    func inputVIew(_ view: CommentInputView, comment: String) {
        view.clearTextAfterPost()
    }
}
