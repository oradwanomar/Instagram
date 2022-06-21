//
//  FeedController.swift
//  Instagram
//
//  Created by Omar Ahmed on 19/05/2022.
//

import UIKit
import Firebase

private let identifier = "cell"
class FeedController : UICollectionViewController {
    
    // MARK: - LifeCycle
    
    private var posts: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configueUI()
        fetchPostsFromFirebase()
        setUPNavBar()
    }
    
    //MARK: - Call API
    
    func fetchPostsFromFirebase(){
        PostService.fetchPosts { posts in
            self.posts = posts
            self.collectionView.refreshControl?.endRefreshing()
            self.collectionView.reloadData()
        }
    }
    
    
    // MARK: - Helpers
    
    func setUPNavBar(){
        let logo = UIImage(named: "logo")
        logo?.withTintColor(.label, renderingMode: .alwaysTemplate)
        let imageView = UIImageView(image:logo)
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
        
        let messageButton = UIButton(type: .system)
        messageButton.setImage(UIImage(named: "message")?.withRenderingMode(.alwaysOriginal), for: .normal)
        messageButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: messageButton)
        
        let logOutButton = UIButton(type: .system)
        logOutButton.tintColor = .secondaryLabel
        logOutButton.setImage(UIImage(systemName: "rectangle.portrait.and.arrow.right")?.withRenderingMode(.automatic), for: .normal)
        logOutButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: logOutButton)
        logOutButton.addTarget(self, action:#selector(handleLogout) , for: .touchUpInside)
    }
    
    func configueUI(){
        collectionView.backgroundColor = .systemBackground
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: identifier)
        
        let refresher = UIRefreshControl()
        refresher.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        collectionView.refreshControl = refresher
    }
    
    @objc func didPullToRefresh(){
        posts.removeAll()
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
    
}

// MARK: UICollectionViewDataSource

extension FeedController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! FeedCell
        cell.viewModel = PostsViewModel(post: posts[indexPath.row])
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
