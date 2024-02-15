//
//  AppError.swift
//  NYTimesArticles
//
//  Created by Macbook on 14/02/2024.
//

import Foundation

internal enum AppError: Error {
    case noInternet
    case failedFetchArticlesMetaData

    
    var errorCode: String {
        switch self {
        case .noInternet:
            return "E_NO_CONNECTION"

        case .failedFetchArticlesMetaData:
            return "E_ARTICLES_META_DATA"
    }
    }

    init?(code: String) {
        switch code {
        case "E_NO_CONNECTION":
            self = .noInternet
        case "E_ARTICLES_META_DATA":
            self = .failedFetchArticlesMetaData
        default:
            return nil
        }
    }
}
