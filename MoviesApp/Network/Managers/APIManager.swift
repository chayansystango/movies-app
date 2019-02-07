//
//  APIManager.swift
//  MoviesApp
//
//  Created by Chayan on 25/01/19.
//  Copyright © 2019 Systango Technologies Pvt Ltd. All rights reserved.
//

import UIKit

enum Result {
    case success(APIResponse)
    case failure(String)
}

struct URLConstant {
    static let baseLiveURL = "https://s3.eu-west-2.amazonaws.com"
}

struct APIManager {
    
    let manager = Manager<MoviesApi>()
    
    func getMovies(completion: @escaping APICompletion) {
        manager.request(.getList) { result in
            completion(result)
        }
    }
}
