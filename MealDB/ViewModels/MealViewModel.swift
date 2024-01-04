//
//  MealViewModel.swift
//  MealDB
//
//  Created by naga vineel golla on 1/3/24.
//

import Foundation

class MealViewModel: ObservableObject {
    @Published var meal: Meal?
    @Published var error: NetworkError? = nil
    @Published var status: status? = nil
    let mealId: String
        
    var service: MealServiceProtocol
    
    init(service: MealServiceProtocol, mealId: String) {
        self.service = service
        self.mealId = mealId
    }
    
    func getMeals() {
        self.status = .Loading
        let endPoint = EndPoint.mealDetails(mealId: mealId)
        
        self.service.getMealsBy(type: MealResponse.self, endPoint: endPoint) {[weak self] result in
            switch result {
            case .success(let mealResponse):
                DispatchQueue.main.async {
                    if let meal = mealResponse?.meal?.first {
                        self?.status = .Loaded
                        self?.meal = meal
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.error = error
                    self?.status = .error
                }
            }
        }
    }
}
