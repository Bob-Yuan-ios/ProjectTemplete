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
            let items = (1...pageSize).map{ i in
                CellModel(title: "标题 \(i + page * pageSize)", description: "动态行高测试，内容长度可能会变化 " + String(repeating: "🍎", count: Int.random(in: 5...50)))
            }
            observer.onNext(items)
            observer.onCompleted()
            return Disposables.create()
        }
    }
    
    static func requestAPI1() -> Observable<String> {
        return Observable.create{ observer in
            DispatchQueue.global().asyncAfter(deadline: .now() + 2){
                observer.onNext("数据 1")
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
    
    static func requestAPI2() -> Observable<String> {
        return Observable.create{ observer in
            DispatchQueue.global().asyncAfter(deadline: .now() + 3){
                observer.onNext("数据 2")
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
    
    static func requestAPI3() -> Observable<String> {
        return Observable.create{ observer in
            DispatchQueue.global().asyncAfter(deadline: .now() + 1.5){
                observer.onNext("数据 3")
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
}
