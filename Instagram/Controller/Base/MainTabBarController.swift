//
//  MainTabBarController.swift
//  Instagram
//
//  Created by Omar Ahmed on 18/05/2022.
//

import UIKit
import Firebase
import YPImagePicker

class MainTabBarController : UITabBarController {
    
    // MARK: - Properties
    
    let profileViewModel = ProfileViewModel()
    
    var user : User? {
        didSet {
            guard let user = user else {return}
            configueViewControllers(withUser: user)
        }
    }
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkIfUserLoggedIn()
        fetchUsersFromFirebase()
        setUpNavBarStyle()
    }
    
    // MARK: - Helpers
    
    func fetchUsersFromFirebase(){
        profileViewModel.fetchUserWithCompletion { user in
            self.user = user
        }
    }
    
    func checkIfUserLoggedIn(){
        let login = LogInController()
        login.delegate = self
        let logInNav = UINavigationController(rootViewController: login)
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                logInNav.modalPresentationStyle = .fullScreen
                self.present(logInNav, animated: true, completion: nil)
            }
        }
    }
    
    func didFinishPick(_ picker:YPImagePicker){
        picker.didFinishPicking { items, cancelled in
            picker.dismiss(animated: true) {
                guard let selectedImage = items.singlePhoto?.image else {return}
                debugPrint(selectedImage)
                let uploadVC = UploadPostViewController()
                uploadVC.selectedImage = selectedImage
                uploadVC.delegate = self
                uploadVC.currentUser = self.user
                let nav = UINavigationController(rootViewController: uploadVC)
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
        }
    }
    
    func configueViewControllers (withUser user : User){
        view.backgroundColor = .white
        self.delegate = self
        let feed = templatesNavigationControllers(selectedImage: UIImage(named: "home_selected")!, unselectedImage: UIImage(named: "home_unselected")!, rootViewController: FeedController(collectionViewLayout: UICollectionViewFlowLayout()))
        
        let search = templatesNavigationControllers(selectedImage: UIImage(named: "search_selected")!, unselectedImage: UIImage(named: "search_unselected")!, rootViewController: SearchController())
        
        let imageSelector = templatesNavigationControllers(selectedImage: UIImage(named: "plus_unselected")!, unselectedImage: UIImage(named: "plus_unselected")!, rootViewController: ImageSelectorController())
        
        let notification = templatesNavigationControllers(selectedImage: UIImage(named: "like_selected")!, unselectedImage: UIImage(named: "like_unselected")!, rootViewController: NotificationController())
        
        let profile = templatesNavigationControllers(selectedImage: UIImage(named: "profile_selected")!, unselectedImage: UIImage(named: "profile_unselected")!, rootViewController: ProfileController(user: user))
        
        viewControllers = [feed,search,imageSelector,notification,profile]
        
        tabBar.tintColor = .label
    }
    
    func setUpNavBarStyle(){
        self.tabBar.layer.masksToBounds = true
        self.tabBar.isTranslucent = true
        self.tabBar.layer.cornerRadius = 28
        self.tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    func templatesNavigationControllers(selectedImage : UIImage , unselectedImage:UIImage , rootViewController : UIViewController) -> UINavigationController {
        
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = unselectedImage
        nav.tabBarItem.selectedImage = selectedImage
        nav.navigationBar.tintColor = .label
        
        return nav
    }
}

//MARK: AuthDelegate
extension MainTabBarController : AuthDelegate {
    func authDidCompleted() {
        fetchUsersFromFirebase()
        self.dismiss(animated: true, completion: nil)
    }
}

//MARK: TabBarDelegate

extension MainTabBarController : UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let index = viewControllers?.firstIndex(of: viewController)
        if index == 2 {
            var config = YPImagePickerConfiguration()
            config.library.mediaType = .photo
            config.shouldSaveNewPicturesToAlbum = false
            config.startOnScreen = .library
            config.screens = [.library]
            config.hidesBottomBar = false
            config.hidesStatusBar = false
            config.hidesCancelButton = false
            config.library.maxNumberOfItems = 1
            
            let picker = YPImagePicker(configuration: config)
            picker.modalPresentationStyle = .fullScreen
            present(picker, animated: true, completion: nil)
            didFinishPick(picker)
        }
        return true
    }
}

// MARK: didFinishUploadDelegate

extension MainTabBarController: UploadPostControllerDelegate {
    func didFinishUploadPost(_ controller: UploadPostViewController) {
        selectedIndex = 0
        controller.dismiss(animated: true, completion: nil)
        
        guard let feedNav = viewControllers?.first as? UINavigationController else {return}
        guard let feed = feedNav.viewControllers.first as? FeedController else {return}
        feed.didPullToRefresh()
    
    }
}
