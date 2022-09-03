//
//  MealModel.swift
//  food_book_app
//
//  Created by Cenk Bahadır Çark on 3.09.2022.
//

import Foundation

struct MealResponse: Codable {
    let meals: [Response]?
}
struct Response : Codable {
    let strMeal : String?
    let strCategory : String?
    let strArea : String?
    let strInstructions : String?
    let strMealThumb : String?
    
}
