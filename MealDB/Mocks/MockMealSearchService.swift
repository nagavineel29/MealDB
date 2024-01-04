//
//  MockMealSearchService.swift
//  MealDB
//
//  Created by naga vineel golla on 1/3/24.
//

import Foundation

let mock = """
{
    "meals": [
        {
            "strMeal": "White chocolate creme brulee",
            "strMealThumb": "https://www.themealdb.com/images/media/meals/uryqru1511798039.jpg",
            "idMeal": "52917"
        },
        {
            "strMeal": "Apple & Blackberry Crumble",
            "strMealThumb": "https://www.themealdb.com/images/media/meals/xvsurr1511719182.jpg",
            "idMeal": "52893"
        },
        {
            "strMeal": "Apple Frangipan Tart",
            "strMealThumb": "https://www.themealdb.com/images/media/meals/wxywrq1468235067.jpg",
            "idMeal": "52768"
        }
    ]
}
"""

class MockMealSearchService: MealServiceProtocol {
    var isSuccess = true
    func getMealsBy<T>(type: T.Type, endPoint: EndPoint, completionHandler: @escaping (Result<T?, NetworkError>) -> Void) where T : Decodable, T : Encodable {
        if isSuccess {
            do {
                let mealResponse = try JSONDecoder().decode(T.self, from: Data(mock.utf8))
                DispatchQueue.main.async {
                    completionHandler(.success(mealResponse))
                }
            } catch {
                DispatchQueue.main.async {
                    return completionHandler(.failure(.decodeError))
                }
            }
        } else {
            return completionHandler(.failure(.NoData))
        }
    }
}
