//
//  API.swift
//  ProjectTemplete
//
//  Created by Bob on 2025/2/8.
//

import Moya
import Foundation

enum API {
    case getTodo(id: Int)
}


extension API: TargetType {
    var method: Moya.Method {
        return .get
    }
    
    var task: Moya.Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    var baseURL: URL {
        return URL(string: "https://jsonplaceholder.typicode.com")!
    }
    
    var path: String {
        switch self {
            case .getTodo(let id):
                return "/todos/\(id)"
        }
    }
}
