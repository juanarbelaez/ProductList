//
//  ProductListInteractor.swift
//  ProductList
//
//  Created by Juan Arbelaez on 3/03/25.
//

import Foundation


protocol ProductListInteractable: AnyObject {
    func getProductList(completion: @escaping (Result<ProductResponseEntity,NetworkError>)-> Void)
}

class ProductListInteractor: ProductListInteractable {
    func getProductList(completion: @escaping (Result<ProductResponseEntity, NetworkError>) -> Void) {
        let requestModel = RequestModel(endpoint: .products, httpMethod: .GET)
        let url = URL(string: requestModel.getURL())!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    completion(.failure(.serverError))
                    return
                }
                do {
                    let productResponseEntity = try JSONDecoder().decode(ProductResponseEntity.self, from: data)
                    completion(.success(productResponseEntity))
                } catch {
                    completion(.failure(.decodingError))
                }
            }
        }.resume()
    }
}
