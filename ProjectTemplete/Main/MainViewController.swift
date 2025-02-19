//
//  MainViewController.swift
//  ProjectTemplete
//
//  Created by Bob on 2025/2/8.
//

import UIKit
import RxSwift
import RxCocoa

class MainViewController: UIViewController {
    
    var coordinator: MainCoordinator?
    private let viewModel = MainViewModel()
    private let disposeBag = DisposeBag()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Click to Load Data"
        label.numberOfLines = 0
        label.frame = CGRect(x: 50, y: 200, width: 300, height: 150)
        return label
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Fetch Data", for: .normal)
        button.frame = CGRect(x: 100, y: 380, width: 200, height: 50)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        setupUI()
        bindViewModel()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        self.title = "设置"

        view.addSubview(label)
        view.addSubview(button)
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
