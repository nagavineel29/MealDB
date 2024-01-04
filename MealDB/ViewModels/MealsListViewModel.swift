//
//  MealsViewModel.swift
//  MealDB
//
//  Created by naga vineel golla on 1/3/24.
//

import Foundation
import SwiftUI

class MealsListViewModel: ObservableObject {
    @Published var meals: [Meal] = []
    @Published var error: NetworkError? = nil
    @Published var status: status? = nil
        
    var service: MealServiceProtocol
    
    init(service: MealServiceProtocol) {
        self.service = service
    }
    
    func getMeals() {
        self.status = .Loading
        let endPoint = EndPoint.searchCategory(category: "Dessert")
        
        self.service.getMealsBy(type: MealsListResponse.self, endPoint: endPoint) {[weak self] result in
            switch result {
            case .success(let mealsListResponse):
                DispatchQueue.main.async {
                    if let meals = mealsListResponse?.meals {
                        self?.sortAndFilterMeals(meals: meals)
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
    
    func sortAndFilterMeals(meals: [Meal]) {
        self.meals = meals.filter({ !$0.mealId.isEmpty && !$0.mealName.isEmpty}).sorted(by: { $0.mealName < $1.mealName })
        self.status = .Loaded
    }
}

enum status {
    case Loading
    case Loaded
    case error
}
