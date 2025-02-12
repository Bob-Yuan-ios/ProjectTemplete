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

    init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()
    }
    
    func start() {
        
        if isUserLoggedIn() {
            print("showMain...")
            showMainFlow()
        }else{
            print("showAuth...")
            showAuthFlow()
        }
    }

    
    func showMainFlow() {
        
        let tabBarController = MainTabBarController()
        
        let listCoordinator = ListCoordinator()
        let mainCoordinator = MainCoordinator()
        
        tabBarController.viewControllers = [
            listCoordinator.navigationController,
            mainCoordinator.navigationController
        ]
        
        listCoordinator.start()
        mainCoordinator.start()
        
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }
    
    func showAuthFlow() {
        let authCoordinator = AuthCoordinator(navigationController: navigationController, parent: self)
        authCoordinator.start()
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    func showListFlow() {
        let listCoordinator = ListCoordinator()
        listCoordinator.start()
    }
    
    private func isUserLoggedIn() -> Bool {
        return  UserDefaults.standard.bool(forKey: "isLoggedIn")
    }
}
