//
//  MovieDetailViewController.swift
//  MoviesApp
//
//  Created by Chayan on 24/01/19.
//  Copyright © 2019 Systango Technologies Pvt Ltd. All rights reserved.
//

import UIKit
import youtube_ios_player_helper

class MovieDetailViewController: BaseViewController {
    
    /// Outlets
    @IBOutlet weak var movieDetailsTableView: UITableView!
    @IBOutlet weak var trailerLoaderView: UIView!
    @IBOutlet weak var trailerActivityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var videoPlayerView: YTPlayerView!
    
    /// Variables
    var selectedMovie: MovieModel!
    var movieDetailViewModel = MovieDetailViewModel()
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupYoutubeMovieTrailerView()
        title = selectedMovie.title
    }

    // MARK: - Private methods
    
    fileprivate func setupYoutubeMovieTrailerView() {
        trailerLoaderView.layer.cornerRadius = 5.0
        videoPlayerView.load(withVideoId: movieDetailViewModel.getVideoIdFrom(youTubeLink: selectedMovie.trailerUrl))
        videoPlayerView.delegate = self
    }
    
}

extension MovieDetailViewController: YTPlayerViewDelegate {
    
    // MARK: - YTPlayerViewDelegate methods
    
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        DispatchQueue.main.async {
            self.trailerLoaderView.isHidden = true
            self.trailerActivityIndicatorView.stopAnimating()
        }
    }
}

extension MovieDetailViewController: UITableViewDataSource {
    
    // MARK: - UITableViewDataSource methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieDetailViewModel.getTotalSpecifications()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.movieSpecifications) as! MovieSpecificationsTableViewCell
        let specData = movieDetailViewModel.getSpecificationData(for: indexPath.row, movie: selectedMovie)
        cell.specTitleLabel.text = specData.title
        cell.specDescriptionLabel.text = specData.description
        return cell
    }
    
}
