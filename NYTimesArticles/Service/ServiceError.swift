//
//  ServiceError.swift
//  NYTimesArticles
//
//  Created by Macbook on 14/02/2024.
//

import Foundation

enum ServiceError: Error, Equatable  {
   case parameterEncodingFailed
   case requestFailed(String?)
   case internetNotAvailable
    
    var errorDescription: String {
        switch self {
        case .parameterEncodingFailed:
            return "Some unknown error occured, please try again later."
        case .requestFailed(let string):
            if let string = string {
                return string
            }
            return "Some unknown error occured, please try again later."
            
        case .internetNotAvailable:
            return "Internet not available."
        }
    }
}
