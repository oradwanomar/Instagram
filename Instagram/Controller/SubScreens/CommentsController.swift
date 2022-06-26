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
    
    
    //MARK: lifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
    }
    
    func configureCollectionView(){
        title = "Comments"
        collectionView.backgroundColor = .systemBackground
        collectionView.register(CommentCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }


}

// MARK: UICollectionViewDataSource

extension CommentsController {

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
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
