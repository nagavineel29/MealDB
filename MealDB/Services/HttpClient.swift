//
//  HttpClient.swift
//  MealDB
//
//  Created by naga vineel golla on 1/3/24.
//

import Foundation

protocol httpClient {
    func getPublisher(urlRequest: URLRequest, completionHandler: @escaping(Result<(Data,HTTPURLResponse), NetworkError>) -> Void)
}

extension URLSession : httpClient {
    func getPublisher(urlRequest: URLRequest, completionHandler: @escaping (Result<(Data, HTTPURLResponse), NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: urlRequest) { data, urlResponse, error in
            guard let data = data, let urlResponse = urlResponse as? HTTPURLResponse else {
                return completionHandler(.failure(.unKnownError(error: error?.localizedDescription ?? "")))
            }
            
            return completionHandler(.success((data, urlResponse)))
        }.resume()
    }
}
