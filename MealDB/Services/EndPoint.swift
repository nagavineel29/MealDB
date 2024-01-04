//
//  EndPoint.swift
//  MealDB
//
//  Created by naga vineel golla on 1/3/24.
//

import Foundation

struct EndPoint {
    var path: String
    var queryItems: [URLQueryItem] = []
    
    var url : URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "themealdb.com"
        components.path = path
        components.queryItems = queryItems
        
        return components.url
    }
}

extension EndPoint {
    static func searchCategory(category: String) -> Self {
        EndPoint (path: "/api/json/v1/1/filter.php",
                  queryItems: [URLQueryItem(name: "c", value: category)])
    }
    
    static func mealDetails(mealId: String) -> Self {
        EndPoint (path: "/api/json/v1/1/lookup.php",
                  queryItems: [URLQueryItem(name: "i", value: mealId)])
    }
}
