//
//  MainCoordinator.swift
//  ProjectTemplete
//
//  Created by Bob on 2025/2/8.
//

import UIKit

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController

    init() {
        self.navigationController = UINavigationController()
        
        self.navigationController.tabBarItem = UITabBarItem(
           title: "设置",                             // 设置 Tab 标题
           image: UIImage(systemName: "gear"),        // 设置 Tab 图标
           selectedImage: UIImage(systemName: "gear.fill")  // 设置选中的图标
       )
    }
    
    func start() {
        let homeVC = MainViewController()
        homeVC.coordinator = self
        navigationController.viewControllers = [homeVC]
    }
    
    func navigateToDetail(){
        print("清空登录信息...")
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
    }
}
