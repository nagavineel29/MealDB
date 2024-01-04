//
//  MealListView.swift
//  MealDB
//
//  Created by naga vineel golla on 1/3/24.
//

import SwiftUI

struct MealListView: View {
    @StateObject var viewModel: MealsListViewModel = MealsListViewModel(service: MealSearchService())
    
    var body: some View {
        NavigationStack {
            Group {
                if let status = viewModel.status {
                    switch status {
                    case .Loading:
                        ProgressView(Constants.loading)
                    case .Loaded:
                        List {
                            ForEach(viewModel.meals) { meal in
                                NavigationLink(value: meal) {
                                    MealCell(meal: meal)
                                }
                            }
                        }
                    case .error:
                        if let error = viewModel.error {
                            Text(error.description)
                        }
                    }
                }
            }
            .navigationTitle(Constants.meals)
            .navigationDestination(for: Meal.self) { meal in
                MealDetailView(meal: meal)
            }
        }
        .task {
            viewModel.getMeals()
        }
    }
}

struct MealCell: View {
    let meal: Meal
    var body: some View {
        HStack(spacing: 12) {
            ImageView(url: meal.poster ?? "")
                .frame(width: 80, height: 80)
            
            Text(meal.mealName)
                .foregroundColor(.primary)
        }
        .padding()
    }
}

#Preview {
    MealListView()
}
