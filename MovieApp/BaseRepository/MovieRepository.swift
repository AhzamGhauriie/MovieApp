//
//  MovieRepository.swift
//  MovieApp
//
//  Created by Ahzam Ghori on 29/07/2023.
//

import Foundation

class MovieRepository: BaseRepository {
    
    //MARK:- Variables:
    private var MovieRDS: MovieRemoteDataSource!
    
    //initilizer:
    override init() {
        super.init()
        MovieRDS = MovieRemoteDataSource()
    }
    
    // MARK: - Get Movie Listing
    func getMovieList(page: Int, completion: @escaping (MovieModel?,Pagination?) -> () , errorCompletion : @escaping (ServerErrorResponse? , String?) -> ()){
        self.MovieRDS.getMovieList(page: page) { (data, page, failure) in
            guard failure == nil else{
                self.switchFailure(failure!, errorCompletion: errorCompletion)
                return
            }
            if data != nil && page != nil{
                completion(data!,page!)
            }
        }
    }
    
    // MARK: - Get Movie Details
    func getMovieDetails(id: Int, completion: @escaping (MovieDetailModel?) -> () , errorCompletion : @escaping (ServerErrorResponse? , String?) -> ()){
        self.MovieRDS.getMovieDetails(id: id) { (data, failure) in
            guard failure == nil else{
                self.switchFailure(failure!, errorCompletion: errorCompletion)
                return
            }
            if data != nil {
                completion(data!)
            }
        }
    }
}
