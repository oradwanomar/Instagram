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
        let feed = FeedController()
        let search = SearchController()
        let imageSelector = ImageSelectorController()
        let notification = NotificationController()
        let profile = ProfileController()
        
        viewControllers = [feed,search,imageSelector,notification,profile]
    }
}
