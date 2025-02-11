//
//  ListAPI.swift
//  ProjectTemplete
//
//  Created by Bob on 2025/2/11.
//

import Foundation
import RxSwift

class ListAPIService {
    static func fetchItems(page: Int, pageSize: Int) -> Observable<[CellModel]> {
        return Observable.create{ observer in
//            DispatchQueue.global().asyncAfter(deadline: .now() + 2){
//
//            }
            let items = (1...pageSize).map{ i in
                CellModel(title: "标题 \(i + page * pageSize)", description: "动态行高测试，内容长度可能会变化 " + String(repeating: "🍎", count: Int.random(in: 5...50)))
            }
            observer.onNext(items)
            observer.onCompleted()
            return Disposables.create()
        }
    }
}
