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
//    var profileViewModel = ProfileViewModel()
    
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
//        profileViewModel.bindingUserViewModelToView = {
//            self.fetchUser()
//        }
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
        return 14
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: profileIdentifier, for: indexPath) as! ProfileCell
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
            print("unfollow")
        }else{
            UserService.follow(uid: user.uid) { error in
                print("Error : in follow function")
            }
            print("follow")
        }
    }
}
