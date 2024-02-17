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
}
