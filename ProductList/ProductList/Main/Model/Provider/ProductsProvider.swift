//
//  ProductsProvider.swift
//  ProductList
//
//  Created by Juan Arbelaez on 9/12/24.
//

import Foundation


protocol ProductsProviderProtocol {
    func getProducts() async throws -> ProductModel
}

class ProductsProvider: ProductsProviderProtocol {
    func getProducts() async throws -> ProductModel {
        let requestModel = RequestModel(endpoint: .products, httpMethod: .GET)
        
        do{
            let model = try await ServiceLayer.callService(requestModel, ProductModel.self)
            return model
        }catch{
            print(error)
            throw error
        }
        
    }
}
