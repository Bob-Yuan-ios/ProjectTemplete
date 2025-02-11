//
//  ListCoordinator.swift
//  ProjectTemplete
//
//  Created by Bob on 2025/2/11.
//

import UIKit

class ListCoordinator: Coordinator {
    var navigationController: UINavigationController
    weak var parent: AppCoordinator?
    
    init(navigationController: UINavigationController, parent: AppCoordinator? = nil) {
        self.navigationController = navigationController
        self.parent = parent
    }
    
    func start() {
        let listVC = ListViewController()
        listVC.coordinator = self
        navigationController.setViewControllers([listVC], animated: true)
    }
    

}
