//
//  ListAPI.swift
//  ProjectTemplete
//
//  Created by Bob on 2025/2/11.
//

import Foundation
import RxSwift

class ListAPIService {
    static func fetchItems(page: Int, pageSize: Int) -> Observable<[Item]> {
        return Observable.create{ observer in
//            DispatchQueue.global().asyncAfter(deadline: .now() + 2){
//
//            }
            let items = (1...pageSize).map{ i in
                Item(id: (page - 1) * pageSize, title: "Item \((page - 1) * pageSize + i)")
            }
            observer.onNext(items)
            observer.onCompleted()
            return Disposables.create()
        }
    }
}
