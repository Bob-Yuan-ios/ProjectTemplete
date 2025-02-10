//
//  LoginViewModel.swift
//  ProjectTemplete
//
//  Created by Bob on 2025/2/10.
//

import Foundation
import RxSwift
import RxCocoa

class LoginViewModel {
    
    let username = BehaviorRelay<String>(value: "")
    let password = BehaviorRelay<String>(value: "")
    let loginTap = PublishSubject<Void>()
    
    var isLoginEnabled: Observable<Bool> {
        return Observable.combineLatest(username, password)
            .map{ !$0.isEmpty && !$1.isEmpty}
            .distinctUntilChanged()
    }
    
    let loginResult = PublishSubject<Bool>()
    
    private let disposeBag = DisposeBag()
    
    init() {
        loginTap
            .withLatestFrom(Observable.combineLatest(username, password))
            .flatMapLatest{ (username, password) in
                return LoginAPI.login(username: username, password: password)
                        .catchAndReturn(false)
            }
            .bind(to: loginResult)
            .disposed(by: disposeBag)
    }
}
