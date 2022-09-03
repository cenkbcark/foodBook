//
//  CategoryModel.swift
//  food_book_app
//
//  Created by Cenk Bahadır Çark on 2.09.2022.
//

import Foundation

struct CategoriesResponse: Codable {
    let categories: [Category]?
}

struct Category: Codable {
    let idCategory, strCategory: String?
    let strCategoryThumb: String?
    let strCategoryDescription: String?
}
