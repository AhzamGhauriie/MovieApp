//
//  DetailViewModel.swift
//  MovieApp
//
//  Created by Ahzam Ghori on 30/07/2023.
//

import Foundation

// MARK: - Protocols:
protocol DetailViewModelDelegate: AnyObject {
    func reloadTableView()
}

class DetailViewModel: BaseViewModel {
    
    // MARK: - Variables:
    var movieRepository : MovieRepository = MovieRepository()
    weak var delegate : DetailViewModelDelegate?
    var moviesData : MovieDetailModel?
    
    // MARK: - Initilizer:
    init(binding : DetailViewModelDelegate, movieId: Int) {
        super.init()
        self.delegate = binding
        getMovieData(movieId: movieId)
    }
    
    // MARK: - Get Movie Listing
    func getMovieData(movieId: Int) {
        movieRepository.getMovieDetails(id: movieId, completion:  { (response) in
            
            guard let jobsData = response else {
                return
            }
            self.moviesData = jobsData
            self.delegate?.reloadTableView()
        }, errorCompletion: { (ServerErrorResponse, message) in
            self.isLoading = false
            if let message = message {
                self.errorMessage = message
                return
            }
            if let message = ServerErrorResponse?.message {
                self.errorMessage = message
                return
            }
        })
    }
}
