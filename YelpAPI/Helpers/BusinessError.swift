//
//  BusinessError.swift
//  YelpAPI
//
//  Created by Andrew Acton on 2/9/23.
//

import Foundation

enum BusinessError: LocalizedError {
    
    case invalidURL
    case thrownError(Error)
    case noData
    case unableToDecode
    
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Unabel to reach Yelp API"
        case .thrownError(let error):
            return "Error: \(error.localizedDescription) -- \(error)"
        case .noData:
            return "The server returned no data"
        case .unableToDecode:
            return "Unable to decode the data"
        }
    }
}
