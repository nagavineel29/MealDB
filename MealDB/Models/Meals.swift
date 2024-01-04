//
//  Meals.swift
//  MealDB
//
//  Created by naga vineel golla on 1/3/24.
//

import Foundation

struct MealsListResponse: Codable {
    let meals: [Meal]?
    
    init(meals: [Meal]) {
        self.meals = meals
    }
}

struct MealResponse: Codable {
    let meal: [Meal]?
    
    private enum CodingKeys: String, CodingKey {
        case meal = "meals"
    }
}

struct Meal: Codable, Identifiable, Hashable {
    var id: UUID = UUID()
    var mealId: String
    var mealName: String
    var poster: String?
    
    var category:  String?
    var area: String?
    var instructions: String?
    var tags: String?
    var youtube: String?
    
    var ingredient1: String?
    var ingredient2: String?
    var ingredient3: String?
    var ingredient4: String?
    var ingredient5: String?
    var ingredient6: String?
    var ingredient7: String?
    var ingredient8: String?
    var ingredient9: String?
    var ingredient10: String?
    var ingredient11: String?
    var ingredient12: String?
    var ingredient13: String?
    var ingredient14: String?
    var ingredient15: String?
    var ingredient16: String?
    var ingredient17: String?
    var ingredient18: String?
    var ingredient19: String?
    var ingredient20: String?
    
    var measure1: String?
    var measure2: String?
    var measure3: String?
    var measure4: String?
    var measure5: String?
    var measure6: String?
    var measure7: String?
    var measure8: String?
    var measure9: String?
    var measure10: String?
    var measure11: String?
    var measure12: String?
    var measure13: String?
    var measure14: String?
    var measure15: String?
    var measure16: String?
    var measure17: String?
    var measure18: String?
    var measure19: String?
    var measure20: String?
    
    var source: String?
    
    init(mealId: String, mealName: String, poster: String) {
        self.mealId = mealId
        self.mealName = mealName
        self.poster = poster
    }
    
    private enum CodingKeys: String, CodingKey {
        case mealId = "idMeal"
        case mealName = "strMeal"
        case poster = "strMealThumb"
        case category = "strCategory"
        case area = "strArea"
        case instructions = "strInstructions"
        case tags = "strTags"
        case youtube = "strYoutube"
        case ingredient1 = "strIngredient1"
        case ingredient2 = "strIngredient2"
        case ingredient3 = "strIngredient3"
        case ingredient4 = "strIngredient4"
        case ingredient5 = "strIngredient5"
        case ingredient6 = "strIngredient6"
        case ingredient7 = "strIngredient7"
        case ingredient8 = "strIngredient8"
        case ingredient9 = "strIngredient9"
        case ingredient10 = "strIngredient10"
        case ingredient11 = "strIngredient11"
        case ingredient12 = "strIngredient12"
        case ingredient13 = "strIngredient13"
        case ingredient14 = "strIngredient14"
        case ingredient15 = "strIngredient15"
        case ingredient16 = "strIngredient16"
        case ingredient17 = "strIngredient17"
        case ingredient18 = "strIngredient18"
        case ingredient19 = "strIngredient19"
        case ingredient20 = "strIngredient20"
        case measure1 = "strMeasure1"
        case measure2 = "strMeasure2"
        case measure3 = "strMeasure3"
        case measure4 = "strMeasure4"
        case measure5 = "strMeasure5"
        case measure6 = "strMeasure6"
        case measure7 = "strMeasure7"
        case measure8 = "strMeasure8"
        case measure9 = "strMeasure9"
        case measure10 = "strMeasure10"
        case measure11 = "strMeasure11"
        case measure12 = "strMeasure12"
        case measure13 = "strMeasure13"
        case measure14 = "strMeasure14"
        case measure15 = "strMeasure15"
        case measure16 = "strMeasure16"
        case measure17 = "strMeasure17"
        case measure18 = "strMeasure18"
        case measure19 = "strMeasure19"
        case measure20 = "strMeasure20"
        case source = "strSource"
    }
    
    subscript(key: Int) -> (String,String)? {
        if let ingredient = self["ingredient\(key)"] , let measure = self["measure\(key)"], !ingredient.isEmpty, !measure.isEmpty {
            return (ingredient,measure)
        }
        return nil
    }
    
    subscript(key: String) -> String? {
        switch key {
        case "ingredient1": return ingredient1
        case "ingredient2": return ingredient2
        case "ingredient3": return ingredient3
        case "ingredient4": return ingredient4
        case "ingredient5": return ingredient5
        case "ingredient6": return ingredient6
        case "ingredient7": return ingredient7
        case "ingredient8": return ingredient8
        case "ingredient9": return ingredient9
        case "ingredient10": return ingredient10
        case "ingredient11": return ingredient11
        case "ingredient12": return ingredient12
        case "ingredient13": return ingredient13
        case "ingredient14": return ingredient14
        case "ingredient15": return ingredient15
        case "ingredient16": return ingredient16
        case "ingredient17": return ingredient17
        case "ingredient18": return ingredient18
        case "ingredient19": return ingredient19
        case "ingredient20":  return ingredient20
            
        case "measure1": return measure1
        case "measure2": return measure2
        case "measure3": return measure3
        case "measure4": return measure4
        case "measure5": return measure5
        case "measure6": return measure6
        case "measure7": return measure7
        case "measure8": return measure8
        case "measure9": return measure9
        case "measure10": return measure10
        case "measure11": return measure11
        case "measure12": return measure12
        case "measure13": return measure13
        case "measure14": return measure14
        case "measure15": return measure15
        case "measure16": return measure16
        case "measure17": return measure17
        case "measure18": return measure18
        case "measure19": return measure19
        case "measure20": return measure20

        default: return ""
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        mealId = try container.decodeIfPresent(String.self, forKey: .mealId) ?? ""
        mealName = try container.decodeIfPresent(String.self, forKey: .mealName) ?? ""
        poster = try container.decodeIfPresent(String.self, forKey: .poster)
        
        category = try container.decodeIfPresent(String.self, forKey: .category)
        area = try container.decodeIfPresent(String.self, forKey: .area)
        instructions = try container.decodeIfPresent(String.self, forKey: .instructions)
        tags = try container.decodeIfPresent(String.self, forKey: .tags)
        youtube = try container.decodeIfPresent(String.self, forKey: .youtube)
        
        ingredient1 = try container.decodeIfPresent(String.self, forKey: .ingredient1)
        ingredient2 = try container.decodeIfPresent(String.self, forKey: .ingredient2)
        ingredient3 = try container.decodeIfPresent(String.self, forKey: .ingredient3)
        ingredient4 = try container.decodeIfPresent(String.self, forKey: .ingredient4)
        ingredient5 = try container.decodeIfPresent(String.self, forKey: .ingredient5)
        ingredient6 = try container.decodeIfPresent(String.self, forKey: .ingredient6)
        ingredient7 = try container.decodeIfPresent(String.self, forKey: .ingredient7)
        ingredient8 = try container.decodeIfPresent(String.self, forKey: .ingredient8)
        ingredient9 = try container.decodeIfPresent(String.self, forKey: .ingredient9)
        ingredient10 = try container.decodeIfPresent(String.self, forKey: .ingredient10)
        ingredient11 = try container.decodeIfPresent(String.self, forKey: .ingredient11)
        ingredient12 = try container.decodeIfPresent(String.self, forKey: .ingredient12)
        ingredient13 = try container.decodeIfPresent(String.self, forKey: .ingredient13)
        ingredient14 = try container.decodeIfPresent(String.self, forKey: .ingredient14)
        ingredient15 = try container.decodeIfPresent(String.self, forKey: .ingredient15)
        ingredient16 = try container.decodeIfPresent(String.self, forKey: .ingredient16)
        ingredient17 = try container.decodeIfPresent(String.self, forKey: .ingredient17)
        ingredient18 = try container.decodeIfPresent(String.self, forKey: .ingredient18)
        ingredient19 = try container.decodeIfPresent(String.self, forKey: .ingredient19)
        ingredient20 = try container.decodeIfPresent(String.self, forKey: .ingredient20)
        
        measure1 = try container.decodeIfPresent(String.self, forKey: .measure1)
        measure2 = try container.decodeIfPresent(String.self, forKey: .measure2)
        measure3 = try container.decodeIfPresent(String.self, forKey: .measure3)
        measure4 = try container.decodeIfPresent(String.self, forKey: .measure4)
        measure5 = try container.decodeIfPresent(String.self, forKey: .measure5)
        measure6 = try container.decodeIfPresent(String.self, forKey: .measure6)
        measure7 = try container.decodeIfPresent(String.self, forKey: .measure7)
        measure8 = try container.decodeIfPresent(String.self, forKey: .measure8)
        measure9 = try container.decodeIfPresent(String.self, forKey: .measure9)
        measure10 = try container.decodeIfPresent(String.self, forKey: .measure10)
        measure11 = try container.decodeIfPresent(String.self, forKey: .measure11)
        measure12 = try container.decodeIfPresent(String.self, forKey: .measure12)
        measure13 = try container.decodeIfPresent(String.self, forKey: .measure13)
        measure14 = try container.decodeIfPresent(String.self, forKey: .measure14)
        measure15 = try container.decodeIfPresent(String.self, forKey: .measure15)
        measure16 = try container.decodeIfPresent(String.self, forKey: .measure16)
        measure17 = try container.decodeIfPresent(String.self, forKey: .measure17)
        measure18 = try container.decodeIfPresent(String.self, forKey: .measure18)
        measure19 = try container.decodeIfPresent(String.self, forKey: .measure19)
        measure20 = try container.decodeIfPresent(String.self, forKey: .measure20)
        
        source = try container.decodeIfPresent(String.self, forKey: .source)
      }
}
