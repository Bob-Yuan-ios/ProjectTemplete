//
//  ListDetailViewModel.swift
//  ProjectTemplete
//
//  Created by Bob on 2025/2/12.
//

import RxSwift
import RxCocoa

class ListDetailViewModel {
    let disposeBag = DisposeBag()
    
    let combineData = PublishRelay<String>()
    
    init() {
        print("listDetailViewModel init...")
    }
    
    func fetchData() {
        
        // 模拟多接口数据异步返回组装后回显
        Observable.zip(
            ListAPIService.requestAPI1(),
            ListAPIService.requestAPI2(),
            ListAPIService.requestAPI3()
        )
        .map{ user, order, message in
           let result = "用户信息：\(user),订单信息：\(order),留言信息：\(message), "
            return result
        }
        .observe(on: MainScheduler.instance)
        .bind(to: combineData)
        .disposed(by: disposeBag)
    }
    
}
