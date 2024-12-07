//
//  ProductModel.swift
//  ProductList
//
//  Created by Juan Arbelaez on 6/12/24.
//

import Foundation


// MARK: - ProductModel
struct ProductModel: Codable {
    let id: Int
    let title: String
    let price: Double
    let description, category: String
    let image: String
}

