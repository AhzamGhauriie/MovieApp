//
//  BaseModel.swift
//  Scout App
//
//  Created by Osama Mansoori on 11/27/20.
//  Copyright © 2020 AppiskeyUser. All rights reserved.
//

import Foundation

//Error Message Response:
class ServerErrorResponse: Decodable {
    
    var error_description: String?
    var status: Int?
    var message: String?
    var email: [String]?
    var forgotPasswordEmail: String?
    var error: String?
    var errors: [String: Any]?
    var password: String?
    var oldPassword: String?
    var observation: String?
    var questionnaire_not_filled: String?
    var inspection_payment_status: String?
    
    enum CodingKeys : String , CodingKey {
        case error_description
        case status
        case message
        case email
        case forgotPasswordEmail
        case error
        case errors
        case password
        case oldPassword
        case observation
        case questionnaire_not_filled
        case inspection_payment_status
    }
    
    public required init(from decoder : Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.error_description = try? container.decodeIfPresent(String.self, forKey: .error_description)
        self.status = try? container.decodeIfPresent(Int.self, forKey: .status)
        self.message = try? container.decodeIfPresent(String.self, forKey: .message)
        self.email = try? container.decodeIfPresent([String].self, forKey: .email)
        self.error = try? container.decodeIfPresent(String.self, forKey: .error)
        
        if let errorsDict = try? container.decodeIfPresent([String: [String]].self, forKey: .errors) {
            
            if let passwordValue = errorsDict["password"]?.first{
                self.password = passwordValue
            }
            
            if let emailValue = errorsDict["email"]?.first{
                self.forgotPasswordEmail = emailValue
            }
            
            if let old_passwordValue = errorsDict["old_password"]?.first{
                self.oldPassword = old_passwordValue
            }
            
            if let observation_nameValue = errorsDict["observation_name"]?.first{
                self.observation = observation_nameValue
            }
            
            if let questionnaire_not_filledValue = errorsDict["questionnaire_not_filled"]?.first{
                self.questionnaire_not_filled = questionnaire_not_filledValue
            }
            
            if let inspection_payment_statusValue = errorsDict["inspection_payment_status"]?.first{
                self.inspection_payment_status = inspection_payment_statusValue
            }
        }
    }
}

// Server Message Response:
struct ServerMessageResponse: Decodable {
    var message: String
}

// Server Test Message Error:
struct TestErrorResponse: Decodable {
    var message: String?
}
