//
//  MovieRemoteDataSource.swift
//  MovieApp
//
//  Created by Ahzam Ghori on 29/07/2023.
//

import Foundation

struct MovieRemoteDataSource {
    
    // MARK: - Api Call Functions
    func getMovieList(page: Int, completion: @escaping (MovieModel?, Pagination?, Failure?) -> ()) {
        Router.APIRouter(endPoint: .movie, appendingURL: "&page=\(page)", parameters: nil, method: .get) { response in
            switch response {
            case .success(let success):
                guard let data = try? JSONDecoder().decode(MovieModel?.self, from: success.data) else {
                    completion(nil,nil, Failure(message: "Unable to parse data.", state: .unknown, data: nil, code: nil))
                    return
                }
                
                guard let page = try? JSONDecoder().decode(Pagination.self, from: success.data) else {
                    completion(data,nil,Failure(message: "Unable to parse page", state: .unknown, data: nil, code: nil))
                    return
                }
                
                completion(data,page,nil)
            case .failure(let failure):
                completion(nil,nil,failure)
            }
        }
    }
    
    // MARK: - Api Call Functions
    func getMovieDetails(id: Int, completion: @escaping (MovieDetailModel?, Failure?) -> ()) {
        Router.APIRouter(endPoint: .detail, appendingURL: "\(id)?api_key=bc76ef1bfe09a8a42ce1c7d0680821ca", parameters: nil, method: .get) { response in
            switch response {
            case .success(let success):
                guard let data = try? JSONDecoder().decode(MovieDetailModel?.self, from: success.data) else {
                    completion(nil, Failure(message: "Unable to parse data.", state: .unknown, data: nil, code: nil))
                    return
                }
               
                completion(data,nil)
            case .failure(let failure):
                completion(nil,failure)
            }
        }
    }
}
