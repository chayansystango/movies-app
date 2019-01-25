//
//  APIResponse.swift
//  MoviesApp
//
//  Created by Chayan on 24/01/19.
//  Copyright © 2019 Systango Technologies Pvt Ltd. All rights reserved.
//

import UIKit

struct APIResponse {
    var body: [String: Any]?
    var header: [String: Any]?
    var statusCode: Int?
    var errorMessage: String?
}
