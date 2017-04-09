//
//  ViewController.swift
//  GlobantMovies
//
//  Created by Santiago Apaza on 4/9/17.
//  Copyright © 2017 Hacuchis. All rights reserved.
//

import UIKit

let kMovieCellIdentifier = "GPMovieCell"
let kMovieDetailSegueIdentifier = "toMovieDetailSegue"

class MovieViewController: UIViewController {
    
    // MARK: - iboutlets
    @IBOutlet weak var movieTableView: UITableView!
    
    // MARK: - variables
    var refreshControl: UIRefreshControl!
    var isRefreshing = false
    var arrayMovies: [GPMovie] = []
    var movieSelected: GPMovie?
    var sortAscending = true
    
    // MARK: - private functions
    private func setupRefreshControl() {
        self.isRefreshing = true
        self.refreshControl = UIRefreshControl()
        self.refreshControl.tintColor = UIColor.white
        self.refreshControl.addTarget(self, action: #selector(self.setupTableViewData), for: .valueChanged)
        self.movieTableView.addSubview(refreshControl)
    }
    
    private func endRefreshTableView() {
        if isRefreshing {
            self.refreshControl.endRefreshing()
        }
    }
    
    private func setupTableViewConfiguration() {
        movieTableView.delegate = self
        movieTableView.dataSource = self
    }
    
    // MARK: - public functions
    func setupTableViewData() {
        GPAPIManager.getMovies(
            success: {
                movies in
                self.arrayMovies = movies
                self.movieTableView.reloadData()
                self.endRefreshTableView()
        },
            failure: {
                error in
                print(error)
                self.endRefreshTableView()
        })
    }
    
    // MARK: - override functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableViewConfiguration()
        self.setupRefreshControl()
        self.setupTableViewData()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == kMovieDetailSegueIdentifier {
            let vc = segue.destination as! MovieDetailViewController
            vc.movie = self.movieSelected
        }
    }
    // MARK: - ibactions    
    
    @IBAction func sortMovies(_ sender: Any) {
        
        var comparitionResult = ComparisonResult.orderedAscending
        
        if !self.sortAscending {
            comparitionResult = ComparisonResult.orderedDescending
        }
        
        self.sortAscending = !self.sortAscending
        
        self.arrayMovies = self.arrayMovies.sorted {
            if let firstTitle = $0.title,
                let secondTitle = $1.title {
                
                    return firstTitle.localizedCaseInsensitiveCompare(secondTitle) == comparitionResult
            } else {
                return false
            }
        }
        self.movieTableView.reloadData()
    }
}

// MARK: - extension: tableview
extension MovieViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let movie = arrayMovies[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: kMovieCellIdentifier) as! MovieCell
        cell.setupCell(movie: movie)
        
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayMovies.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        movieSelected = self.arrayMovies[indexPath.row]
        self.performSegue(withIdentifier: kMovieDetailSegueIdentifier, sender: self)
    }
}
