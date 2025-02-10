//
//  MainCoordinator.swift
//  ProjectTemplete
//
//  Created by Bob on 2025/2/8.
//

import UIKit

class MainCoordinator: Coordinator{
    var navigationController: UINavigationController
    weak var parent: AppCoordinator?
    
    init(navigationController: UINavigationController, parent: AppCoordinator? = nil) {
        self.navigationController = navigationController
        self.parent = parent
    }
    
    func start() {
        let homeVC = HomeViewController()
        homeVC.coordinator = self
        navigationController.setViewControllers([homeVC], animated: true)
    }
    
    func navigateToDetail(){
        print("清空登录信息...")
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
        
        parent?.removeCoordinator(self)
        parent?.showAuthFlow()
    }
}
