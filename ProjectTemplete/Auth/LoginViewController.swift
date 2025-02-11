//
//  LoginViewController.swift
//  ProjectTemplete
//
//  Created by Bob on 2025/2/8.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class LoginViewController: UIViewController{
    
    weak var coordinator: AuthCoordinator?
    
    private let disposeBag = DisposeBag()
    private let viewModel = LoginViewModel()
    
    private lazy var usernameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "输入用户名"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "输入密码"
        textField.isSecureTextEntry = true
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("登录", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.gray, for: .disabled)
        button.isEnabled = false
        button.layer.cornerRadius = 8
        button.backgroundColor = .blue
        return button
    }()
    
    private lazy var actiIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        bindViewModel()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(usernameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        view.addSubview(actiIndicator)

        usernameTextField.snp.makeConstraints{ make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(80)
            make.left.right.equalToSuperview().inset(40)
            make.height.equalTo(44)
        }
        
        passwordTextField.snp.makeConstraints{ make in
            make.top.equalTo(usernameTextField.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(40)
            make.height.equalTo(44)
        }
        
        loginButton.snp.makeConstraints{ make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(40)
            make.left.right.equalToSuperview().inset(40)
            make.height.equalTo(44)
        }
        
        actiIndicator.snp.makeConstraints{ make in
            make.center.equalToSuperview()
        }
    }
    
    private func bindViewModel() {
        
        usernameTextField.rx.text.orEmpty
            .bind(to: viewModel.username)
            .disposed(by: disposeBag)
        
        passwordTextField.rx.text.orEmpty
            .bind(to: viewModel.password)
            .disposed(by: disposeBag)
        
        loginButton.rx.tap
            .bind(to: viewModel.loginTap)
            .disposed(by: disposeBag)
        
        viewModel.isLoginEnabled
            .bind(to: loginButton.rx.isEnabled)
            .disposed(by: disposeBag)        
        
        viewModel.loginTap
            .subscribe(onNext: { [weak self] in
                self?.actiIndicator.startAnimating()
            })
            .disposed(by: disposeBag)
        
        viewModel.loginResult
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] success in
                self?.actiIndicator.stopAnimating()
                
                if success {
                    self?.showLoginSuccess()
                } else {
                    self?.showLoginError()
                }
            })
            .disposed(by: disposeBag)
       
    }
    
    @objc func showLoginSuccess() {
        print("保存登录信息...")
        
        UserDefaults.standard.set(true, forKey: "isLoggedIn")
        coordinator?.didList()
    }
    
    private func showLoginError() {
          let alert = UIAlertController(title: "登录失败", message: "用户名或密码错误", preferredStyle: .alert)
          alert.addAction(UIAlertAction(title: "确定", style: .default))
          present(alert, animated: true)
      }
}
