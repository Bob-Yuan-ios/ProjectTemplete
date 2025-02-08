//
//  LoginViewController.swift
//  ProjectTemplete
//
//  Created by Bob on 2025/2/8.
//

import UIKit

class LoginViewController: UIViewController{

    weak var coordinator: AuthCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let loginButton = UIButton(type: .system)
        loginButton.setTitle("Login", for: .normal)
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        loginButton.frame = CGRect(x: 0, y: 0, width: 300, height: 44)
        view.addSubview(loginButton)
        loginButton.center = view.center
        
        
        print("Hello login...")
    }
    
    @objc func loginTapped() {
        UserDefaults.standard.set(true, forKey: "isLoggedIn")
        coordinator?.didFinishAuth()
    }
}
