//
//  MovieDetailViewController.swift
//  GlobantMovies
//
//  Created by Santiago Apaza on 4/9/17.
//  Copyright © 2017 Hacuchis. All rights reserved.
//

import UIKit
import Kingfisher

class MovieDetailViewController: UIViewController {
    private let kImageSize = "w500"
    
    // MARK: - iboutlets
    @IBOutlet weak var fullMovieImage: UIImageView!
    @IBOutlet weak var titleMovieLabell: UILabel!
    @IBOutlet weak var originalTitleMovieLabell: UILabel!
    @IBOutlet weak var releaseDateMovieLabell: UILabel!
    @IBOutlet weak var overviewMovieTextField: UITextView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    // MARK: - variables
    var movie: GPMovie?
    
    // MARK: - private functions
    private func setupMovieInfo() {
        if let mov = self.movie {
            if let title = mov.title {
                self.titleMovieLabell.text = title
            }
            if let originalTitle = mov.originalTitle {
                self.originalTitleMovieLabell.text =  originalTitle
            }
            if let releaseDate = mov.releaseDate {
                self.releaseDateMovieLabell.text = releaseDate
            }
            if let overview = mov.overview {
                self.overviewMovieTextField.text = overview
            }
            
            if let poster = mov.backdropPath {
                
                self.fullMovieImage.layer.cornerRadius = 8
                
                self.activityIndicator.startAnimating()
                let posterPathString = "\(kImageBasePath)\(kImageSize)\(poster)"
                let posterPathURL = URL(string: posterPathString)
                self.fullMovieImage.kf.setImage(with: posterPathURL, completionHandler: {
                    (image, error, _, _) in
                    self.activityIndicator.stopAnimating()
                })
            }
        }
    }
    
    // MARK: - override functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupMovieInfo()
    }
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

// function to translate to another date format
extension String {
    func convertStringDate2StringDate(formatOrigin: String = "yyyy-MM-dd",
                                      formatDestination: String = "hh:mm dd/MM/yyyy") -> String? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        dateFormatter.dateFormat = formatOrigin
        
        if let dateObj = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = formatDestination
            return dateFormatter.string(from: dateObj)
        } else {
            return nil
        }
    }
}
