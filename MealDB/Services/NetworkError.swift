//
//  NetworkError.swift
//  MealDB
//
//  Created by naga vineel golla on 1/3/24.
//

import Foundation

enum NetworkError: Error {
    case badUrl
    case NoData
    case badResponse
    case unKnownError(error: String)
    case decodeError
    
    var description : String {
        switch self {
            
        case .badUrl:
            return "Bad Url"
        case .NoData:
            return "No Data"
        case .badResponse:
            return "bad Response"
        case .unKnownError(let error):
            return "\(error)"
        case .decodeError:
            return "decode error"
        }
    }
}
