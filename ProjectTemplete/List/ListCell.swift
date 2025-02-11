//
//  ListCell.swift
//  ProjectTemplete
//
//  Created by Bob on 2025/2/11.
//

import UIKit

class ListCell: UITableViewCell {
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.numberOfLines = 0  // 允许多行
        return label
    }()
    
    
    private var descLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .darkGray
        label.numberOfLines = 0  // 允许多行
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setupUI()
    }
  
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupUI() {
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(descLabel)
        
        // 约束
      titleLabel.snp.makeConstraints { make in
          make.top.equalToSuperview().offset(10)
          make.left.right.equalToSuperview().inset(15)
      }
              
        descLabel.snp.makeConstraints { make in
              make.top.equalTo(titleLabel.snp.bottom).offset(8)
              make.left.right.equalToSuperview().inset(15)
              make.bottom.equalToSuperview().offset(-10)  // 关键：确保 bottom 约束！
          }
    }
    
    func configure(with model: CellModel){
        titleLabel.text = model.title
        descLabel.text = model.description
    }
}
