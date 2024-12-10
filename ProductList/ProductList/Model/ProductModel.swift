//
//  ProductModel.swift
//  ProductList
//
//  Created by Juan Arbelaez on 6/12/24.
//

import Foundation

//
//// MARK: - ProductModel
//struct ProductModel: Decodable {
//    let id: Int
//    let title: String
//    let price: Double
//    let description, category: String
//    let image: String
//}
//


// MARK: - ProductModelElement
struct ProductDetail: Codable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: Category
    let image: String
}

enum Category: String, Codable {
    case electronics = "electronics"
    case jewelery = "jewelery"
    case menSClothing = "men's clothing"
    case womenSClothing = "women's clothing"
}


typealias ProductModel = [ProductDetail]

