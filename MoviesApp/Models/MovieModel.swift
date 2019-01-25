//
//  MovieModel.swift
//  MoviesApp
//
//  Created by Chayan on 24/01/19.
//  Copyright © 2019 Systango Technologies Pvt Ltd. All rights reserved.
//

struct MovieModel {
    var movieId = ""
    var title = ""
    var posterUrl = ""
    var summary = ""
    var cast = ""
    var director = ""
    var year = ""
    var trailerUrl = ""
    var genre = ""
    
    init() {
    }
    
    init(_ dict: [String: Any]) {
        if let id = dict["id"] as? String {
            movieId = id
        }
        if let movieTitle = dict["title"] as? String {
            title = movieTitle
        }
        if let poster = dict["poster"] as? String {
            posterUrl = poster
        }
        if let movieSummary = dict["summary"] as? String {
            summary = movieSummary
        }
        if let movieCast = dict["cast"] as? String {
            cast = movieCast
        }
        if let movieDirector = dict["director"] as? String {
            director = movieDirector
        }
        if let movieYear = dict["year"] as? String {
            year = movieYear
        }
        if let movieTrailer = dict["trailer"] as? String {
            trailerUrl = movieTrailer
        }
        if let movieGenre = dict["genre"] as? String {
            genre = movieGenre
        }
    }
}
