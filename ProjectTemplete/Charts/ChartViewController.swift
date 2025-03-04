//
//  ChartViewController.swift
//  ProjectTemplete
//
//  Created by Bob on 2025/2/19.
//

import UIKit
import SnapKit

class ChartViewController: UIViewController, UIScrollViewDelegate {
    
    var coordinator: ChartCoordinator?
    private var allChartData: [[ChartDataModel]] = []
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: CGRectZero)
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        return scrollView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "图表"
        
        view.addSubview(scrollView)
        
        scrollView.snp.makeConstraints { make in
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
            make.left.right.equalToSuperview()
        }
        
    }
    
    
}
