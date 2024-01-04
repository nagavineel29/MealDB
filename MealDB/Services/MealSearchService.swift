//
//  MealSearchService.swift
//  MealDB
//
//  Created by naga vineel golla on 1/3/24.
//

import Foundation


protocol MealServiceProtocol {
    func getMealsBy<T: Codable>(type: T.Type, endPoint: EndPoint, completionHandler: @escaping(Result<T?, NetworkError>) -> Void)
}

class MealSearchService: MealServiceProtocol {
    func getMealsBy<T>(type: T.Type, endPoint: EndPoint, completionHandler: @escaping (Result<T?, NetworkError>) -> Void) where T : Decodable, T : Encodable {
        
        guard let url = endPoint.url else { return completionHandler(.failure(.badUrl)) }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.getPublisher(urlRequest: request) {result in
            switch result {
            case .success((let data, let urlResponse)):
                switch urlResponse.statusCode {
                    case 204:
                    DispatchQueue.main.async {
                        completionHandler(.failure(.NoData))
                    }
                    case 200:
                        do {
                            let mealResponse = try JSONDecoder().decode(T.self, from: data)
                            DispatchQueue.main.async {
                                completionHandler(.success(mealResponse))
                            }
                        } catch {
                            DispatchQueue.main.async {
                                return completionHandler(.failure(.decodeError))
                            }
                        }
                default:
                    DispatchQueue.main.async {
                        return completionHandler(.failure(.badResponse))
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    completionHandler(.failure(error))
                }
            }
        }
    }
}
