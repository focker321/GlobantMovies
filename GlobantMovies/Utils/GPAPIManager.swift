//
//  GPAPIManager.swift
//  GlobantMovies
//
//  Created by Santiago Apaza on 4/9/17.
//  Copyright © 2017 Hacuchis. All rights reserved.
//


import Foundation
import Alamofire


private let kBaseURLServer = "http://api.themoviedb.org/3"
private let kApiKey = "d73db914dac006d1c918264e2b2e6517"

class GPAPIManager {
    class func getMovies(by findingKind: String = "discover",
                                success: @escaping ((_ movies: [GPMovie]) -> Void),
                                failure: @escaping ((_ error: String)-> Void)) {
        let urlRequest = "\(kBaseURLServer)/\(findingKind)/movie"
        let urlRequestParameters = "\(urlRequest)?sort_by=popularity.desc&api_key=\(kApiKey)"
        print(urlRequestParameters)
        Alamofire.request(urlRequestParameters,
            method: .get).validate().responseJSON { response in
                switch response.result {
                case .success:
                    if let result = response.result.value as? [String : AnyObject] {
                        let movies = GPMovie.arrayFromJson(json: result)
                        success(movies)
                    } else {
                        failure("Response no tiene el formato adecuado")
                    }
                case .failure(let error):
                    failure("\(error)")
                }
        }
    }
}
