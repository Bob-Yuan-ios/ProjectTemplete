//
//  APIService.swift
//  ProjectTemplete
//
//  Created by Bob on 2025/2/8.
//

import RxSwift
import Moya
import RxMoya
import Foundation

class APIService {
    static let shared = APIService()
    
#if DEBUG
    let provider = MoyaProvider<API>(plugins: [
        // 配置日志插件，打印详细日志
        NetworkLoggerPlugin(configuration: .init(logOptions: [.verbose]))
    ])
#else
    private let provider = MoyaProvider<API>()
#endif

    func fetchTodo(id: Int) -> Observable<String> {
          
        return provider.rx.request(.getTodo(id: 1))
            .map { response -> String in
                return String(data: response.data, encoding: .utf8) ?? "Invalid Data"
            }
            .asObservable()
    }
    
}
