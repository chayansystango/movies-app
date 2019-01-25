//
//  Constants.swift
//  MoviesApp
//
//  Created by Chayan on 24/01/19.
//  Copyright © 2019 Systango Technologies Pvt Ltd. All rights reserved.
//

import Foundation
import UIKit

// MARK: - API

enum UserAPIEndpoints : String {
    case getMovieList = "ios-movies/list.json"
}

struct URLConstant {
    static let baseLiveURL = "https://s3.eu-west-2.amazonaws.com/"
}

// MARK: - UI

enum Storyboard: String {
    case main = "Main"
}

struct CellIdentifiers {
    static let movie = "MovieCell"
    static let movieSpecifications = "MovieSpecificationsCell"
}
