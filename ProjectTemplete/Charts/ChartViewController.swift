//
//  ChartViewController.swift
//  ProjectTemplete
//
//  Created by Bob on 2025/2/19.
//

import UIKit
import DGCharts
import SnapKit

class ChartViewController: UIViewController, UIScrollViewDelegate, ChartViewDelegate {
    
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
        
        loadData()
    }
    
    private func createChartView(with data: [ChartDataModel]) -> LineChartView {
        
        let chartView = LineChartView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 500))
           chartView.delegate = self  // 监听点击事件
           chartView.highlightPerTapEnabled = true
          
           var dataEntries: [ChartDataEntry] = []
           for dataPoint in data {
               let entry = ChartDataEntry(x: dataPoint.xValue, y: dataPoint.yValue)
               dataEntries.append(entry)
           }
           
           let dataSet = LineChartDataSet(entries: dataEntries, label: "财务数据")
           dataSet.colors = [.blue]
           dataSet.circleColors = [.red]
           dataSet.circleRadius = 6
           dataSet.drawValuesEnabled = false
           
           chartView.data = LineChartData(dataSet: dataSet)
           return chartView
       }
    
    private func loadData() {
        let rawData: [ChartDataModel] = [
            ChartDataModel(xValue: 0, yValue: 5000, description: "周一收入", category: .income),
            ChartDataModel(xValue: 1, yValue: 3000, description: "周二支出", category: .expense),
            ChartDataModel(xValue: 2, yValue: 4500, description: "周三收入", category: .income),
            ChartDataModel(xValue: 3, yValue: 2000, description: "周四支出", category: .expense),
            ChartDataModel(xValue: 4, yValue: 6000, description: "周五收入", category: .income),
            ChartDataModel(xValue: 5, yValue: 5000, description: "周一收入", category: .income),
            ChartDataModel(xValue: 6, yValue: 3000, description: "周二支出", category: .expense),
            ChartDataModel(xValue: 7, yValue: 4500, description: "周三收入", category: .income),
            ChartDataModel(xValue: 8, yValue: 2000, description: "周四支出", category: .expense),
            ChartDataModel(xValue: 9, yValue: 6000, description: "周五收入", category: .income),
            ChartDataModel(xValue: 10, yValue: 5000, description: "周一收入", category: .income),
            ChartDataModel(xValue: 11, yValue: 3000, description: "周二支出", category: .expense),
            ChartDataModel(xValue: 12, yValue: 4500, description: "周三收入", category: .income),
            ChartDataModel(xValue: 13, yValue: 2000, description: "周四支出", category: .expense),
            ChartDataModel(xValue: 14, yValue: 6000, description: "周五收入", category: .income)
        ]
        
        allChartData = stride(from: 0, to: rawData.count, by: 5).map{
            Array(rawData[$0..<min($0 + 5, rawData.count)])
        }
        
        loadCharts()
    }
   
    private func loadCharts() {
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(allChartData.count), height: scrollView.frame.size.height)
        
        for(index, dataSet) in allChartData.enumerated() {
            let chartView = createChartView(with: dataSet)
            chartView.frame.origin.x = CGFloat(index) * view.frame.size.width
            scrollView.addSubview(chartView)
        }
    }
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        
    }
    
    func showDetail(_ data: ChartDataModel){
        let alert = UIAlertController(title: "数据详情",
                                          message: "日期索引: \(data.xValue)\n数值: \(data.yValue)\n类型: \(data.category.rawValue)\n描述: \(data.description)",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "关闭", style: .cancel))
            present(alert, animated: true)
    }
}
