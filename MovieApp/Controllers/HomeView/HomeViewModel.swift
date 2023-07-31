//
//  HomeViewModel.swift
//  MovieApp
//
//  Created by Ahzam Ghori on 29/07/2023.
//

import Foundation

// MARK: - Protocols:
protocol HomeViewModelDelegate: AnyObject {
    func reloadTableView()
}

class HomeViewModel: BaseViewModel {
    
    // MARK: - Variables:
    var movieRepository : MovieRepository = MovieRepository()
    weak var delegate : HomeViewModelDelegate?
    private var isMorePageRequired = true
    var movies : [Result] = []
    var currentPage = 1
    
    // MARK: - Initilizer:
    init(binding : HomeViewModelDelegate) {
        super.init()
        self.delegate = binding
        getMovieData()
    }
    
    // MARK: - Get Movie Data
    func getMovieData() {
        movieRepository.getMovieList(page: currentPage, completion:  { (response, page) in
            
            guard let jobsData = response?.results else {
                return
            }
            
            if self.currentPage == 1 {
                self.movies = jobsData
            } else {
                self.movies.append(contentsOf: jobsData)
            }
            
            if page?.currentPage != nil {
                self.currentPage += 1
                self.isMorePageRequired = true
            } else{
                self.isMorePageRequired = false
            }
            
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
    
    
    // MARK: -  Function for showing nextPage:
    /// pagination for calling new data
    func getNewPageData(itemIndex: Int){
        if itemIndex == self.movies.count - 1 && self.isMorePageRequired {
            self.getMovieData()
        }
    }
}
