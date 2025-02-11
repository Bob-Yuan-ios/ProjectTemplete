//
//  ListViewModel.swift
//  ProjectTemplete
//
//  Created by Bob on 2025/2/11.
//


import Foundation
import RxSwift
import RxCocoa

class ListViewModel {
    
    let refreshTrigger = PublishSubject<Void>()
    let loadMoreTrigger = PublishSubject<Void>()
    
    let items = BehaviorRelay<[Item]>(value: [])
    let isRefreshing = BehaviorRelay<Bool>(value: false)
    let isLoadingMore = BehaviorRelay<Bool>(value: false)
    let hasMoreData = BehaviorRelay<Bool>(value: false)
    
    private var currentPage = 1
    private var pageSize = 20
    private let disposeBag = DisposeBag()

    init() {
        refreshTrigger
            .flatMapLatest{ [weak self] _ -> Observable<[Item]> in
                guard let self = self else { return Observable.just([])}
                
                self.isRefreshing.accept(true)
                self.currentPage = 1
                return ListAPIService.fetchItems(page: self.currentPage, pageSize: self.pageSize)
            }
            .subscribe(onNext: { [weak self] newItems in
                guard let self = self else { return }
                
                self.isRefreshing.accept(false)
                self.hasMoreData.accept(newItems.count == self.pageSize)
                self.currentPage = 2
                self.items.accept(newItems)
            })
            .disposed(by: disposeBag)
        
        
        loadMoreTrigger
            .filter{ [weak self] _ in
                guard let self = self else { return false}
                return !self.isLoadingMore.value && self.hasMoreData.value
            }
            .flatMapLatest{ [weak self] _ -> Observable<[Item]> in
                guard let self = self else { return Observable.just([])}
                
                self.isLoadingMore.accept(true)
                return ListAPIService.fetchItems(page: self.currentPage, pageSize: self.pageSize)
            }
            .subscribe(onNext: { [weak self] newItems in
                guard let self = self else { return }
                
                self.isLoadingMore.accept(false)

                if newItems.count < self.pageSize {
                    self.hasMoreData.accept(false)
                }
                
                self.currentPage += 1
                self.items.accept(self.items.value + newItems)
            })
            .disposed(by: disposeBag)
    }
}
