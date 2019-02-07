//
//  HTTPTask.swift
//  MoviesApp
//
//  Created by Chayan on 07/02/19.
//  Copyright © 2019 Systango Technologies Pvt Ltd. All rights reserved.
//

import Foundation

public enum HTTPTask {
    case request
    case requestParameters(parameters: [String: Any]?)
    case requestParametersAndHeaders(bodyParameters: [String: Any]?, additionHeaders: [String: String]?)
}


