//
//  TabViewController.swift
//  Navigation
//
//  Created by Andrey Kaplun on 10/02/2022.
//  Copyright © 2022 Andrey Kaplun. All rights reserved.
//

import UIKit

class TabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        UITabBar.appearance().barTintColor = .systemBackground
        tabBar.tintColor = .label
        setupViewController()
    }
    
    private func createNavController(for rootViewController: UIViewController,
                                     title: String,
                                     image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.navigationBar.prefersLargeTitles = true
        rootViewController.navigationItem.title = title
        
        return navController
      }
    
    private func setupViewController() {
          viewControllers = [
            createNavController(for: LogInViewController(), title: "Login", image: UIImage(systemName: "lock.fill")!),
            //createNavController(for: FeedViewController(), title: "Feed", image: UIImage(systemName: "house.fill")!),
            createNavController(for: ProfileViewController(), title: "Profile", image: UIImage(systemName: "person.fill")!)
          ]
      }

}
