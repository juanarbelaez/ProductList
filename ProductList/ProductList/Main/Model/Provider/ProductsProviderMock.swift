//
//  ProductsProviderMock.swift
//  ProductList
//
//  Created by Juan Arbelaez on 10/12/24.
//

import Foundation

class ProductsProviderMock : ProductsProviderProtocol {
    func getProducts() async throws -> ProductModel {
        guard let model = Utils.parseJson(jsonName: "Products", model: ProductModel.self) else{
            throw NetworkError.jsonDecoder
        }
        return model
    }
    
    
}
