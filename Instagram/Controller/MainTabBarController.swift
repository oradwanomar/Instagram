//
//  MainTabBarController.swift
//  Instagram
//
//  Created by Omar Ahmed on 18/05/2022.
//

import UIKit

class MainTabBarController : UITabBarController {
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configueViewControllers()
    }
    
    // MARK: - Helpers
    
    func configueViewControllers (){
        view.backgroundColor = .white
        let feed = templatesNavigationControllers(selectedImage: UIImage(named: "home_unselected")!, unselectedImage: UIImage(named: "home_selected")!, rootViewController: FeedController())
        let search = templatesNavigationControllers(selectedImage: UIImage(named: "search_unselected")!, unselectedImage: UIImage(named: "search_selected")!, rootViewController: SearchController())
        let imageSelector = templatesNavigationControllers(selectedImage: UIImage(named: "plus_unselected")!, unselectedImage: UIImage(named: "plus_selected")!, rootViewController: ImageSelectorController())
        let notification = templatesNavigationControllers(selectedImage: UIImage(named: "like_unselected")!, unselectedImage: UIImage(named: "like_selected")!, rootViewController: NotificationController())
        let profile = templatesNavigationControllers(selectedImage: UIImage(named: "profile_unselected")!, unselectedImage: UIImage(named: "profile_selected")!, rootViewController: ProfileController())
        
        viewControllers = [feed,search,imageSelector,notification,profile]
        
        tabBar.tintColor = .label
    }
    
    func templatesNavigationControllers(selectedImage : UIImage , unselectedImage:UIImage , rootViewController : UIViewController) -> UINavigationController {
        
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = unselectedImage
        nav.tabBarItem.selectedImage = selectedImage
        nav.navigationBar.tintColor = .clear
        
        return nav
    }
}
