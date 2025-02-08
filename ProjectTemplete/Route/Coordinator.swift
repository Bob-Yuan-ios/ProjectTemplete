//
//  Coordinator.swift
//  ProjectTemplete
//
//  Created by Bob on 2025/2/8.
//

import UIKit

protocol Coordinator: AnyObject{
    var navigationController: UINavigationController { get set }
    func start()
}
