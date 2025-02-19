//
//  ChartCoordinator.swift
//  ProjectTemplete
//
//  Created by Bob on 2025/2/19.
//

import UIKit

class ChartCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init() {
        self.navigationController = UINavigationController()
        
        self.navigationController.tabBarItem = UITabBarItem(
            title: "图表",
            image: UIImage(systemName: "chart.line.uptrend.xyaxis"),
            selectedImage: UIImage(systemName: "chart.line.uptrend.xyaxis")  // 设置选中的图标（可选）
        )
    }
    
    func start() {
        let chartVC = ChartViewController()
        chartVC.coordinator = self
        navigationController.viewControllers = [chartVC]
    }
    
}
