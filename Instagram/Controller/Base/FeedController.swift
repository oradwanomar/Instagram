//
//  FeedController.swift
//  Instagram
//
//  Created by Omar Ahmed on 19/05/2022.
//

import UIKit
import Firebase

private let identifier = "feedCell"
class FeedController : UICollectionViewController {
    
    // MARK: - LifeCycle
    
    var posts = [Post]()
    let refresher = UIRefreshControl()
    var profilePosts : [Post] = []
    var indexPath: IndexPath?
    var username: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPostsFromFirebase()
        configueUI()
        setUPNavBar()
        setUpPostsFromProfile()
    }
    
    //MARK: - Call API
    
    func fetchPostsFromFirebase(){
        guard profilePosts.count == 0 else {return}
        PostService.fetchPosts { posts in
            self.posts = posts
            self.refresher.endRefreshing()
            self.collectionView.reloadData()
        }
    }
    
    
    // MARK: - Helpers
    
    func setUPNavBar(){
        if profilePosts.count == 0 {
            let logo = UIImage(named: "logo")?.withTintColor(.label, renderingMode: .alwaysOriginal)
            let imageView = UIImageView(image:logo)
            imageView.contentMode = .scaleAspectFit
            self.navigationItem.titleView = imageView
            
            let messageButton = UIButton(type: .system)
            messageButton.setImage(UIImage(named: "message")?.withRenderingMode(.alwaysOriginal), for: .normal)
            messageButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            messageButton.addTarget(self, action: #selector(didTabMessageBtn), for: .touchUpInside)
            navigationItem.rightBarButtonItem = UIBarButtonItem(customView: messageButton)
            
            let logOutButton = UIButton(type: .system)
            logOutButton.tintColor = .secondaryLabel
            logOutButton.setImage(UIImage(systemName: "rectangle.portrait.and.arrow.right")?.withRenderingMode(.automatic), for: .normal)
            logOutButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
            navigationItem.leftBarButtonItem = UIBarButtonItem(customView: logOutButton)
            logOutButton.addTarget(self, action:#selector(handleLogout) , for: .touchUpInside)
        }else {
            let centerTitle = UILabel()
            centerTitle.attributedText = setProfileAttributedTitle(top: "\(username!)", bottom: "Posts")
            navigationItem.titleView = centerTitle
        }

    }
    
    func configueUI(){
        collectionView.backgroundColor = .systemBackground
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: identifier)
        
        if profilePosts.count == 0 {
            refresher.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
            collectionView.addSubview(refresher)
        }
    }
    
    func setUpPostsFromProfile(){
        if profilePosts.count != 0 {
            guard let indexPath = indexPath else {
                return
            }
            collectionView.scrollToItem(at: indexPath, at: .top, animated: true)
        }
    }
    
    // MARK: Obj-C Functions
    
    @objc func didPullToRefresh(){
        posts.removeLast()
        fetchPostsFromFirebase()
    }
    
    @objc func handleLogout(){
        do {
            try Auth.auth().signOut()
                DispatchQueue.main.async {
                    let login = LogInController()
                    login.delegate = self.tabBarController as? MainTabBarController
                    let logInNav = UINavigationController(rootViewController: login)
                    logInNav.modalPresentationStyle = .fullScreen
                    self.present(logInNav, animated: true, completion: nil)
                }
        } catch {
            print("Error : in logout")
        }
    }
    
    @objc func didTabMessageBtn(){
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: 0, section: 0)
            self.collectionView.scrollToItem(at: indexPath, at: .top, animated: true)
        }
    }

    
}

// MARK: UICollectionViewDataSource

extension FeedController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return profilePosts.count == 0 ? posts.count : profilePosts.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! FeedCell
        cell.delegate = self
        
        if profilePosts.count == 0 {
            cell.viewModel = PostsViewModel(post: posts[indexPath.row])
        }else {
            cell.viewModel = PostsViewModel(post: profilePosts[indexPath.row])
        }
        return cell
    }
    
}

extension FeedController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
        var height = width + 8 + 40 + 8
        height += 50
        height += 60
        return CGSize(width: view.frame.width, height: height)
    }
}


// MARK: FeedCellDelegate

extension FeedController: FeedCellDelegate{
    func tabUsername(for cell: FeedCell, wantsToShowCommentsFor post: Post) {
        UserService.fetchUser(forUserID: post.ownerUid) { user in
            let pVC = ProfileController(user: user)
            self.navigationController?.pushViewController(pVC, animated: true)
        }
    }
    
    func cell(for cell: FeedCell, wantsToShowCommentsFor post: Post) {
        let commentVC = CommentsController(post: post)
        navigationController?.pushViewController(commentVC, animated: true)
    }
}
