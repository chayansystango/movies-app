//
//  MovieViewModel.swift
//  MoviesApp
//
//  Created by Chayan on 24/01/19.
//  Copyright © 2019 Systango Technologies Pvt Ltd. All rights reserved.
//

import UIKit

class MovieViewModel: NSObject {
    
    /// Constants
    let kMoviePosterAspectRatio: CGFloat = 1.5
    let kTotalHorizontalSpacing: CGFloat = 30
    let kTotalItemsInRow: CGFloat = 2.0
    
    /// Closures
    typealias MovieCompletionHandler = (_ movies:[MovieModel]) -> Void
    
    // MARK: - API methods
    
    func performGetMovieListAPI(completionHandler: @escaping MovieCompletionHandler) {
        APIManager().getMovies { (result) in
            switch result {
            case .success(let apiResponse):
                var moviesArray = [MovieModel]()
                if let dataArray = apiResponse.body?["data"] as? [[String: Any]] {
                    for movieDict in dataArray {
                        moviesArray.append(MovieModel(movieDict))
                    }
                    completionHandler(moviesArray)
                }
            case .failure(let errorMessage):
                print(errorMessage)
            }
        }
    }
    
    // MARK: Custom methods
    
    func getItemSizeForCollectionView(screenWidth: CGFloat) -> CGSize {
        let width = (screenWidth - kTotalHorizontalSpacing) / kTotalItemsInRow
        let height = width * kMoviePosterAspectRatio
        return CGSize(width: width, height: height)
    }
}
