//
//  ProfileCell.swift
//  Instagram
//
//  Created by Omar Ahmed on 29/05/2022.
//

import UIKit

class ProfileCell : UICollectionViewCell {
    
    //MARK: Properties
    
    var viewModel: PostsViewModel? {
        didSet {
            configureUserPostCell()
        }
    }
    
    
    private let postImageView : UIImageView = {
        let piv = UIImageView()
        piv.image = UIImage(named: "venom")
        piv.contentMode = .scaleAspectFill
        piv.clipsToBounds = true
        return piv
    }()
    
    
    //MARK: LifeCycle
    
    override init(frame:CGRect){
        super.init(frame: frame)
        backgroundColor = .lightGray
        addSubview(postImageView)
        postImageView.fillSuperview()
    }
    
    func configureUserPostCell() {
        guard let viewModel = viewModel else {
            return
        }
        postImageView.sd_setImage(with: URL(string: viewModel.post.imageUrl))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Helper
}
