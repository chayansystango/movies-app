//
//  MovieDetailViewModel.swift
//  MoviesApp
//
//  Created by Chayan on 24/01/19.
//  Copyright © 2019 Systango Technologies Pvt Ltd. All rights reserved.
//

import UIKit

class MovieDetailViewModel: NSObject {
    
    /// Enum
    enum MovieSpecification: Int, CaseIterable {
        case title = 0
        case summary
        case cast
        case director
        case year
        case genre
    }
    
    // MARK: - Custom methods
    
    func getSpecificationData(for index: Int, movie: MovieModel) -> MovieSpecificationModel {
        var movieSpec = MovieSpecificationModel()
        switch index {
        case MovieSpecification.title.rawValue:
            movieSpec.title = "movie_spec_title".localized()
            movieSpec.description = movie.title
        case MovieSpecification.summary.rawValue:
            movieSpec.title = "movie_spec_summary".localized()
            movieSpec.description = movie.summary
        case MovieSpecification.cast.rawValue:
            movieSpec.title = "movie_spec_cast".localized()
            movieSpec.description = movie.cast
        case MovieSpecification.director.rawValue:
            movieSpec.title = "movie_spec_director".localized()
            movieSpec.description = movie.director
        case MovieSpecification.year.rawValue:
            movieSpec.title = "movie_spec_year".localized()
            movieSpec.description = movie.year
        case MovieSpecification.genre.rawValue:
            movieSpec.title = "movie_spec_genre".localized()
            movieSpec.description = movie.genre
        default:
            movieSpec.title = ""
            movieSpec.description = ""
        }
        return movieSpec
    }
    
    func getTotalSpecifications() -> Int {
        return MovieSpecification.allCases.count
    }
    
    func getVideoIdFrom(youTubeLink: String) -> String {
        if let videoId = youTubeLink.youtubeID {
            return videoId
        }
        return ""
    }
}
