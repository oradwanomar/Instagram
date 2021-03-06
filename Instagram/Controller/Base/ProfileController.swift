//
//  ProfileController.swift
//  Instagram
//
//  Created by Omar Ahmed on 19/05/2022.
//

import UIKit

private let profileIdentifier = "profileCell"
private let headerIdentifier = "profileHeader"
class ProfileController : UICollectionViewController {
    
    var user : User
    var posts : [Post] = []
    
    //MARK: LifeCycle
    
    init(user:User){
        self.user = user
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionVIew()
        fetchUser()
        checkUserFollowState()
        checkUserNumbersStates()
        fetchUserPostsFromAPI()
    }
    
    // MARK: Call API
    
    func fetchUserPostsFromAPI(){
        PostService.fetchUserPosts(uid: user.uid) { posts in
            self.posts = posts
            self.collectionView.reloadData()
        }
    }
    
    func checkUserFollowState(){
        let pvm = ProfileViewModel(user: user)
        pvm.checkIfUserIsFollow { isFollowed in
            self.user.isFollowed = isFollowed
            self.collectionView.reloadData()
        }
    }
    
    func checkUserNumbersStates(){
        let pvm = ProfileViewModel(user: user)
        pvm.fetchUserStats { stats in
            self.user.stats = stats
            self.collectionView.reloadData()
        }
    }
    
    // MARK: Helper
    
    func fetchUser(){
            self.navigationItem.title = user.username
            self.collectionView.reloadData()
    }
    
    func configureCollectionVIew(){
        collectionView.backgroundColor = .systemBackground
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(ProfileCell.self, forCellWithReuseIdentifier: profileIdentifier)
        collectionView.register(ProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier)
    }
    
}

//MARK: UICollectionViewDataSource

extension ProfileController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: profileIdentifier, for: indexPath) as! ProfileCell
        cell.viewModel = PostsViewModel(post: posts[indexPath.row])
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath) as! ProfileHeader
        header.phViewModel = ProfileViewModel(user: user)
        header.delegate = self
        return header
    }
    
}

//MARK: UICollectionViewDelegate

extension ProfileController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let feedCV = FeedController(collectionViewLayout: UICollectionViewFlowLayout())
        feedCV.username = user.username
        feedCV.indexPath = indexPath
        feedCV.profilePosts = posts
        navigationController?.pushViewController(feedCV, animated: true)
    }
    
}

//MARK: UICollectionViewDelegateFlowLayout

extension ProfileController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 2) / 3
        return CGSize(width: width, height: width)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 240)
    }
}

// MARK: ProfileDelegateProtocol

extension ProfileController : ProfileDelegateProtocol {
    func header(_ profileHeader: ProfileHeader, didTapActionButtonForUser user: User) {
        if user.isCurrentUser {
            print("current user")
        }else if user.isFollowed {
            UserService.unfollow(uid: user.uid) { error in
                self.user.isFollowed = false
                self.collectionView.reloadData()
            }
        }else{
            UserService.follow(uid: user.uid) { error in
                self.user.isFollowed = true
                self.collectionView.reloadData()
            }
        }
    }
}
