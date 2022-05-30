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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configueUI()
    }
    
    
    // MARK: - Helpers
    
    func configueUI(){
        collectionView.backgroundColor = .systemBackground
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: identifier)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        navigationItem.leftBarButtonItem?.tintColor = .label
        navigationItem.title = "Feed"
    }
    
    @objc func handleLogout(){
        do {
            try Auth.auth().signOut()
            let login = LogInController()
            let logInNav = UINavigationController(rootViewController: login)
            if Auth.auth().currentUser == nil {
                DispatchQueue.main.async {
                    logInNav.modalPresentationStyle = .fullScreen
                    self.present(logInNav, animated: true, completion: nil)
                }
            }
        } catch {
            print("Error : in logout")
        }
    }
    
}

// MARK: UICollectionViewDataSource

extension FeedController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! FeedCell
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
