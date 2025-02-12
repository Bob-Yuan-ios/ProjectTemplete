//
//  MainViewModel.swift
//  ProjectTemplete
//
//  Created by Bob on 2025/2/8.
//

import Foundation

import RxSwift

class MainViewModel{
    
    private let apiService = APIService.shared
    private let disposeBag = DisposeBag()
    
    let responseData = PublishSubject<String>()
    
    func fetchUserData(id: Int){
        print("Fetching user data...")
        apiService.fetchTodo(id: id)
            .subscribe(onNext: { [weak self] result in
                self?.responseData.onNext(result)
            }, onError: {error in
                print("Error: \(error)")
            })
            .disposed(by: disposeBag)
    }
}
