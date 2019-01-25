//
//  APIManager.swift
//  MoviesApp
//
//  Created by Chayan on 25/01/19.
//  Copyright © 2019 Systango Technologies Pvt Ltd. All rights reserved.
//

import UIKit

class APIManager {
    
    /// Perform GET Operations
    static func performGetCallWith(endpoint: UserAPIEndpoints, completionHandler: @escaping (APIResponse?) -> ()) {
        APIRequest.callAPIWith(endPoint: (URLConstant.baseLiveURL + endpoint.rawValue), methodType: .get, parameters: nil, completionHandler: completionHandler)
    }
    
    /// Perform POST Operations
    static func performPostCallWith(endpoint: UserAPIEndpoints, parameters: [String: Any]?, completionHandler: @escaping (APIResponse?) -> ()) {
        APIRequest.callAPIWith(endPoint: (URLConstant.baseLiveURL + endpoint.rawValue), methodType: .post, parameters: parameters, completionHandler: completionHandler)
    }
    
    /// Perform PUT Operations
    static func performPutCallWith(endpoint: UserAPIEndpoints, parameters: [String: Any]?, completionHandler: @escaping (APIResponse?) -> ()) {
        APIRequest.callAPIWith(endPoint: (URLConstant.baseLiveURL + endpoint.rawValue), methodType: .put, parameters: parameters, completionHandler: completionHandler)
    }
    
    /// Perform DELETE Operations
    static func performDeleteCallWith(endpoint: UserAPIEndpoints, parameters: [String: Any]?, completionHandler: @escaping (APIResponse?) -> ()) {
        APIRequest.callAPIWith(endPoint: (URLConstant.baseLiveURL + endpoint.rawValue), methodType: .delete, parameters: parameters, completionHandler: completionHandler)
    }
    
}
