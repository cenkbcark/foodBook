//
//  CategoryModel.swift
//  food_book_app
//
//  Created by Cenk Bahadır Çark on 3.09.2022.
//

import Foundation

struct CategoryResponse : Decodable {
    let meals: [Meal]?
}

struct Meal : Decodable {
    let strMeal: String?
    let strMealThumb: String?
    let idMeal: String?
}
