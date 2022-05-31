//
//  MainTabBarController.swift
//  Instagram
//
//  Created by Omar Ahmed on 18/05/2022.
//

import UIKit
import Firebase

class MainTabBarController : UITabBarController {
    
    // MARK: - LifeCycle
    
    var profileViewModel = ProfileHeaderViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configueViewControllers()
        checkIfUserLoggedIn()
    }
    
    // MARK: - Helpers
    
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
    
    func configueViewControllers (){
        view.backgroundColor = .white
        let feed = templatesNavigationControllers(selectedImage: UIImage(named: "home_selected")!, unselectedImage: UIImage(named: "home_unselected")!, rootViewController: FeedController(collectionViewLayout: UICollectionViewFlowLayout()))
        
        let search = templatesNavigationControllers(selectedImage: UIImage(named: "search_selected")!, unselectedImage: UIImage(named: "search_unselected")!, rootViewController: SearchController())
        
        let imageSelector = templatesNavigationControllers(selectedImage: UIImage(named: "plus_photo")!, unselectedImage: UIImage(named: "plus_unselected")!, rootViewController: ImageSelectorController())
        
        let notification = templatesNavigationControllers(selectedImage: UIImage(named: "like_selected")!, unselectedImage: UIImage(named: "like_unselected")!, rootViewController: NotificationController())
        
        let profile = templatesNavigationControllers(selectedImage: UIImage(named: "profile_selected")!, unselectedImage: UIImage(named: "profile_unselected")!, rootViewController: ProfileController(viewModel: profileViewModel))
        
        viewControllers = [feed,search,imageSelector,notification,profile]
        
        tabBar.tintColor = .label
    }
    
    func templatesNavigationControllers(selectedImage : UIImage , unselectedImage:UIImage , rootViewController : UIViewController) -> UINavigationController {
        
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = unselectedImage
        nav.tabBarItem.selectedImage = selectedImage
        nav.navigationBar.tintColor = .systemBackground
        
        return nav
    }
}
extension MainTabBarController : AuthDelegate {
    func authDidCompleted() {
        profileViewModel.fetchUserFromAPI()
        self.dismiss(animated: true, completion: nil)
    }
}
