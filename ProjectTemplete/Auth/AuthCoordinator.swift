//
//  AuthCoordinator.swift
//  ProjectTemplete
//
//  Created by Bob on 2025/2/8.
//

import UIKit

class AuthCoordinator: Coordinator{
    var navigationController: UINavigationController
    weak var parent: AppCoordinator?
    
    init(navigationController: UINavigationController, parent: AppCoordinator? = nil) {
        self.navigationController = navigationController
        self.parent = parent
    }
    
    func start() {
        let loginVC = AuthViewController()
        loginVC.coordinator = self
        navigationController.pushViewController(loginVC, animated: true)
    }
    
    func didFinishAuth() {
        parent?.showMainFlow()
    }
}
