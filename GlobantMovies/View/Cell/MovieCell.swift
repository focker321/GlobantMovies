//
//  MovieCell.swift
//  GlobantMovies
//
//  Created by Santiago Apaza on 4/9/17.
//  Copyright © 2017 Hacuchis. All rights reserved.
//

import UIKit
import Kingfisher

let kImageBasePath = "http://image.tmdb.org/t/p/"

class MovieCell: UITableViewCell {
    private let kImageSize = "w185"
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieOverviewLabel: UILabel!
    
    func setupCell(movie: GPMovie) {
        
        self.cellView.layer.cornerRadius = 8
        
        if let title = movie.title {
            self.movieTitleLabel.text = title
        }
        
        if let overview = movie.overview {
            self.movieOverviewLabel.text = overview
        }
        
        if let poster = movie.posterPath {
            self.activityIndicator.startAnimating()
            let posterPathString = "\(kImageBasePath)\(kImageSize)\(poster)"
            let posterPathURL = URL(string: posterPathString)
            self.movieImage.kf.setImage(with: posterPathURL, completionHandler: {
                (image, error, _, _) in
                    self.activityIndicator.stopAnimating()
                })
        }
    }
}
