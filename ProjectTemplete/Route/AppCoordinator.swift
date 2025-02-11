//
//  AppCoordinator.swift
//  ProjectTemplete
//
//  Created by Bob on 2025/2/8.
//


import UIKit

class AppCoordinator: Coordinator {
    var window: UIWindow
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    
    init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()
    }
    
    func start() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        if isUserLoggedIn() {
//            showMainFlow()
            showListFlow()
        }else{
            showAuthFlow()
        }
    }

    
    func showMainFlow() {
        let mainCoordinator = MainCoordinator(navigationController: navigationController, parent: self)
        childCoordinators.append(mainCoordinator)
        mainCoordinator.start()
    }
    
    func showAuthFlow() {
        let authCoordinator = AuthCoordinator(navigationController: navigationController, parent: self)
        childCoordinators.append(authCoordinator)
        authCoordinator.start()
    }
    
    func showListFlow() {
        let listCoordinator = ListCoordinator(navigationController: navigationController, parent: self)
        childCoordinators.append(listCoordinator)
        listCoordinator.start()
    }
    
    private func isUserLoggedIn() -> Bool {
        return  UserDefaults.standard.bool(forKey: "isLoggedIn")
    }
    
    
    func removeCoordinator(_ coordinator: Coordinator) {
        childCoordinators.removeAll { $0 === coordinator }
    }
}
