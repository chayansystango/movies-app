//
//  MoviesListViewController.swift
//  MoviesApp
//
//  Created by Chayan on 24/01/19.
//  Copyright © 2019 Systango Technologies Pvt Ltd. All rights reserved.
//

import UIKit
import SDWebImage

class MoviesListViewController: BaseViewController, UIViewControllerTransitioningDelegate, UINavigationControllerDelegate {
    
    /// Outlets
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    
    /// Variables
    var moviesArray = [MovieModel]()
    var movieViewModel = MovieViewModel()
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh(_:)), for: .valueChanged)
        refreshControl.tintColor = .white
        return refreshControl
    }()
    
    /// Constants
    let movieDetailAnimationController = MovieDetailAnimationController()
    
    // MARK: - Lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        getMoviesList()
        configureCollectionView()
        navigationController?.delegate = self
    }
    
    // MARK: - Private methods
    
    fileprivate func getMoviesList() {
        if moviesArray.count == 0 {
            showLoadingIndicator()
        }
        movieViewModel.performGetMovieListAPI { (movies) in
            self.hideLoadingIndicator()
            self.moviesArray = movies
            DispatchQueue.main.async {
                self.moviesCollectionView.reloadData()
                self.refreshControl.endRefreshing()
                self.moviesArray.count == 0 ? self.showNoDataLabel(message: "no_movie_data".localized()) : self.hideNoDataLabel()
            }
        }
    }
    
    fileprivate func configureCollectionView() {
        moviesCollectionView.contentInset = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 20.0, right: 10.0)
        moviesCollectionView.addSubview(refreshControl)
        moviesCollectionView.alwaysBounceVertical = true
    }
    
    // MARK: - UIRefreshControl method
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        getMoviesList()
    }
    
    // MARK: - UINavigationControllerDelegate methods
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if let selectedIndexPath = moviesCollectionView.indexPathsForSelectedItems?.first {
            if let attributes = moviesCollectionView.layoutAttributesForItem(at: selectedIndexPath) {
                movieDetailAnimationController.initialFrame = moviesCollectionView.convert(attributes.frame, to: self.view)
            }
        }
        return operation == .pop ? nil : movieDetailAnimationController
    }
    
}

extension MoviesListViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // MARK: - UICollectionViewDataSource methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifiers.movie, for: indexPath) as! MovieCollectionViewCell
        let movie = moviesArray[indexPath.row]
        let posterPlaceHolderImage = movie.title.createImageWith(frame: cell.posterImageView.frame)
        cell.posterImageView.sd_setImage(with: URL(string: movie.posterUrl), placeholderImage: posterPlaceHolderImage, options: [], completed: nil)
        return cell
    }
    
    // MARK: - UICollectionViewDelegate methods
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movieDetailVC = MovieDetailViewController.instance(storyboard: .main) as! MovieDetailViewController
        movieDetailVC.selectedMovie = moviesArray[indexPath.row]
        movieDetailVC.transitioningDelegate = self
        navigationController?.pushViewController(movieDetailVC, animated: true)
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout methods
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return movieViewModel.getItemSizeForCollectionView(screenWidth: view.frame.size.width)
    }
    
}
