//
//  MoviesEndPoint.swift
//  MoviesApp
//
//  Created by Chayan on 07/02/19.
//  Copyright © 2019 Systango Technologies Pvt Ltd. All rights reserved.
//

import Foundation

public enum MoviesApi {
    case getList
}

extension MoviesApi: EndPointType {
    
    var module: String {
        return "/ios-movies"
    }
    
    var path: String {
        switch self {
        case .getList:
            return "/list.json"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getList:
            return .get
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .getList:
            return .request
        }
    }
    
    var headers: [String: String]? {
        return nil
    }
}
