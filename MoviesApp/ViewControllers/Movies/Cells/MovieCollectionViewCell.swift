//
//  MovieCollectionViewCell.swift
//  MoviesApp
//
//  Created by Chayan on 24/01/19.
//  Copyright © 2019 Systango Technologies Pvt Ltd. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    /// Outlets
    @IBOutlet weak var posterImageView: UIImageView!
    
    // MARK: - Lifecycle methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        posterImageView.sd_setShowActivityIndicatorView(true)
        posterImageView.sd_setIndicatorStyle(.white)
    }
    
}
