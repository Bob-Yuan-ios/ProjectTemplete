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
        let detailVC = DetailViewController()
        navigationController.pushViewController(detailVC, animated: true)
    }
}
