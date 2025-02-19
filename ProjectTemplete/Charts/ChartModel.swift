//
//  ChartModel.swift
//  ProjectTemplete
//
//  Created by Bob on 2025/2/19.
//

import Foundation

enum DataCategory: String {
    case income =  "收入"
    case expense = "支出"
}

struct ChartDataModel {
    let xValue: Double
    let yValue: Double
    let description: String
    let category: DataCategory
}
