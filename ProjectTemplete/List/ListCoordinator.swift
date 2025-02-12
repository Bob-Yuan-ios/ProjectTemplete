//
//  ListCoordinator.swift
//  ProjectTemplete
//
//  Created by Bob on 2025/2/11.
//

import UIKit

class ListCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init() {
        self.navigationController = UINavigationController()
        
        self.navigationController.tabBarItem = UITabBarItem(
           title: "首页",                             // 设置 Tab 标题
           image: UIImage(systemName: "house"),      // 设置 Tab 图标（需要 SF Symbols 或自定义图片）
           selectedImage: UIImage(systemName: "house.fill")  // 设置选中的图标（可选）
       )
    }
    
    func start() {
        let listVC = ListViewController()
        listVC.coordinator = self
        navigationController.viewControllers = [listVC]
    }
    
    func navigationDetail(model: CellModel) {

        print("选择行信息：\(model.title)")
        
        let detailVC = ListDetailViewController()
        detailVC.model = model
        navigationController.pushViewController(detailVC, animated: true)
    }
}
