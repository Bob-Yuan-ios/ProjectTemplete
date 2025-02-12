//
//  AuthAPI.swift
//  ProjectTemplete
//
//  Created by Bob on 2025/2/10.
//

import Foundation
import RxSwift

class AuthAPI {
    static func login(username: String, password: String) -> Observable<Bool> {
        return Observable.create{ observer in
            DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
                if username == "admin" && password == "123456" {
                    observer.onNext(true)
                }else {
                    observer.onNext(false)
                }
                
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
}
