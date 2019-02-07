//
//  EndPointType.swift
//  MoviesApp
//
//  Created by Chayan on 07/02/19.
//  Copyright © 2019 Systango Technologies Pvt Ltd. All rights reserved.
//

import Foundation

protocol EndPointType {
    var path: String { get }
    var module: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: [String: String]? { get }
}

