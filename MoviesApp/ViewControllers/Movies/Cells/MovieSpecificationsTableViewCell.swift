//
//  MovieSpecificationsTableViewCell.swift
//  MoviesApp
//
//  Created by Chayan on 24/01/19.
//  Copyright © 2019 Systango Technologies Pvt Ltd. All rights reserved.
//

import UIKit

class MovieSpecificationsTableViewCell: UITableViewCell {

    /// Outlets
    @IBOutlet weak var specTitleLabel: UILabel!
    @IBOutlet weak var specDescriptionLabel: UILabel!
    
    // MARK: - Lifecycle methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
