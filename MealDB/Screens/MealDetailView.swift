//
//  MealDetailView.swift
//  MealDB
//
//  Created by naga vineel golla on 1/3/24.
//

import SwiftUI

struct MealDetailView: View {
    let meal: Meal?
    @StateObject var viewModel: MealViewModel
    
    init(meal: Meal) {
        self.meal = meal
        self._viewModel = StateObject(wrappedValue:  MealViewModel(service: MealSearchService(), mealId: meal.mealId))
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false, content: {
            VStack {
                ImageView(url: meal?.poster ?? "")
                    .frame(width: UIScreen.main.bounds.width, height:  UIScreen.main.bounds.width)
                VStack {
                    if let status = viewModel.status {
                        switch status {
                        case .Loaded:
                            VStack{
                                Text(viewModel.meal?.mealName ?? "")
                                    .foregroundColor(.primary)
                                    .font(.system(size: 29, weight: .bold))
                                
                                Spacer(minLength: 10)
                                
                                Text(viewModel.meal?.instructions ?? "")
                                    .foregroundColor(.primary)
                                    .font(.system(size: 15, weight: .light))
                            }
                            .padding()
                            
                            mealIngredientView(meal: viewModel.meal)
                        case .Loading:
                            VStack{
                                Text(meal?.mealName ?? "")
                                    .foregroundColor(.primary)
                                    .font(.system(size: 29, weight: .bold))
                                Spacer()
                                ProgressView(Constants.loading)
                            }
                            .padding()
                            .frame(width: UIScreen.main.bounds.width, height: 300)
                        case .error:
                            if let error = viewModel.error {
                                Text(error.description)
                            }
                        }
                    }
                }
                .background(.background)
                .cornerRadius(25)
                .offset(y: -35)
            }
        })
        .ignoresSafeArea(.all, edges: .all)
        .task {
            viewModel.getMeals()
        }
    }
}

struct mealIngredientView: View {
    let meal: Meal?
    
    var body: some View {
        VStack {
            HStack {
                Text(Constants.ingredients)
                    .foregroundColor(.primary)
                    .font(.system(size: 23, weight: .bold))
                
                Spacer()
                
                Text(Constants.serving)
                    .fontWeight(.bold)
                    .foregroundColor(Color.green)
            }
            .padding(.vertical)
            .padding(.horizontal)
            
            ForEach(0..<20) { i in
                if let (ingredient,measure) = meal?[i] {
                    VStack {
                        HStack {
                            Text(ingredient)
                                .foregroundColor(.primary)

                            Spacer()
                            
                            Text(measure)
                                .foregroundColor(.primary)
                                .fontWeight(.bold)
                        }
                        .padding(.vertical)
                        
                        Divider()
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
}
