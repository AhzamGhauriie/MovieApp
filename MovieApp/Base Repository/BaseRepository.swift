//
//  BaseRepository.swift
//  Scout App
//
//  Created by Osama Mansoori on 11/27/20.
//  Copyright © 2020 AppiskeyUser. All rights reserved.
//

import Foundation

class BaseRepository {
    
    enum FetchingType {        
        case local
        case automatic
    }
    
    /// A general method to show alert to user coming from API Request.
    ///
    ///   - Parameters:
    ///   - failure: Server failure response.
    ///   - vc: on view controller which error has to be shown.
    func switchFailure(_ failure: Failure, errorCompletion: @escaping (ServerErrorResponse?, String?) -> Void ) {
        
        if let data = failure.data {
            if let errorResponse = try? JSONDecoder().decode(ServerErrorResponse.self, from: data) {
                errorCompletion(errorResponse, nil)
                return
            } else if let code = failure.code, code == 400 {
                errorCompletion(nil, Messages.invalidCredientials)
            } else {
                if let dic = try? JSONSerialization.jsonObject(with: failure.data!, options: .mutableContainers) as? [String:Any], let first = dic.first, let array = first.value as? [String], let firstValue = array.first {
                    
                    errorCompletion(nil, firstValue)
                } else {
                    errorCompletion(nil, Messages.wentWrongError)
                }
                
            }
        } else {
                errorCompletion(nil, failure.message)
        }
    }
}
