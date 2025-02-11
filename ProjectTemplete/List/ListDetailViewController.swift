//
//  ListDetailViewController.swift
//  ProjectTemplete
//
//  Created by Bob on 2025/2/11.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift

class ListDetailViewController: UIViewController {

    var model: CellModel?
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center

        return label
    }()
    
    
    private lazy var descLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .darkGray
        label.numberOfLines = 0
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        setupUI()
        configureData()
    }
    
    private func setupUI() {
        view.backgroundColor = .white

        view.addSubview(titleLabel)
        view.addSubview(descLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(80)
            make.left.right.equalToSuperview().inset(40)
        }
        
        descLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp_bottomMargin).offset(20)
            make.left.right.equalToSuperview().inset(40)
        }
    }
    
    private func configureData() {
        titleLabel.text = model?.title
        descLabel.text = model?.description
    }
}
