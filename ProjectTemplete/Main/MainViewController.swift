//
//  MainViewController.swift
//  ProjectTemplete
//
//  Created by Bob on 2025/2/8.
//

import UIKit
import RxSwift
import RxCocoa
import Foundation


class MainViewController: UIViewController {
    
    var coordinator: MainCoordinator?
    private let viewModel = MainViewModel()
    private let disposeBag = DisposeBag()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Click to Load Data"
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Fetch Data", for: .normal)
        button.backgroundColor = .lightGray
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        setupUI()
        bindViewModel()
        
        // 调用函数; 测试获取服务器时间
        viewModel.getNetworkTime { date in
            if let ntpDate = date {
                print("NTP 时间: \(ntpDate)")
            } else {
                print("获取 NTP 时间失败")
            }
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .white

        view.addSubview(label)
        view.addSubview(button)
        
        label.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(44)
            make.left.right.equalToSuperview().inset(16)
        }
        
        button.snp.makeConstraints { make in
            make.top.equalTo(label.snp_bottomMargin).offset(10)
            make.left.right.equalToSuperview().inset(16)
        }
    }
    
    private func bindViewModel() {
        button.rx.tap
            .bind { [weak self] in
                self?.viewModel.fetchUserData(id: 1)
            }
            .disposed(by: disposeBag)
        
        viewModel.responseData
            .bind(to: label.rx.text)
            .disposed(by: disposeBag)
    }
    
    @objc func didTapNext() {
        coordinator?.navigateToDetail()
    }
}
