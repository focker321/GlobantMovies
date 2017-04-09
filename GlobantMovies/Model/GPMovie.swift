//
//  GPMovie.swift
//  GlobantMovies
//
//  Created by Santiago Apaza on 4/9/17.
//  Copyright © 2017 Hacuchis. All rights reserved.
//

import Foundation

class GPMovie: NSObject {
    
    // MARK: - variables
    var id: Int?
    var posterPath: String?
    var backdropPath: String?
    var overview: String?
    var releaseDate: String?
    var title: String?
    var originalTitle: String?
    
    override var description: String {
        return "⚡️ Movie -> id: \(String(describing: self.id)) -- title: \(String(describing: self.title))\n"
    }
    // MARK: - initializer
    init(json: [String: Any]) {
        if let id = json["id"] as? Int {
            self.id = id
        }
        if let poster = json["poster_path"] as? String {
            self.posterPath = poster
        }
        if let backdrop = json["backdrop_path"] as? String {
            self.backdropPath = backdrop
        }
        if let overview = json["overview"] as? String {
            self.overview = overview
        }
        if let release = json["release_date"] as? String {
            self.releaseDate = release
        }
        if let title = json["title"] as? String {
            self.title = title
        }
        if let title = json["original_title"] as? String {
            self.originalTitle = title
        }
    }

    // MARK: - public functions
    class func arrayFromJson(json: [String: Any], node: String = "results") -> [GPMovie] {
        var movies: [GPMovie] = []
        if let data = json[node] as? NSArray {
            for element in data {
                if let movie = element as? [String: Any] {
                    movies.append(GPMovie(json: movie))
                }
            }
        }
        return movies
    }
}
