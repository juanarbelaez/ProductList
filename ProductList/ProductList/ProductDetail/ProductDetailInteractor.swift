//
//  ProductDetailInteractor.swift
//  ProductList
//
//  Created by Juan Arbelaez on 5/03/25.
//

import Foundation

protocol ProductDetailInteractable: AnyObject{
    func getProductDetail(withId id: String, completion: @escaping (Result<ProductDetailEntity,NetworkError>)-> Void)
}

class ProductDetailInteractor: ProductDetailInteractable {
    func getProductDetail(withId id: String, completion: @escaping (Result<ProductDetailEntity, NetworkError>) -> Void) {
        let requestModel = RequestModel(endpoint: .productDetail, httpMethod: .GET)
        let url = requestModel.getURL()
        
        
        URLSession.shared.dataTask(with: URL(string: url+"\(id)")!) { data, response, error in
            
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    completion(.failure(.serverError))
                    return
                }
                do {
                    let productResponseEntity = try JSONDecoder().decode(ProductDetailEntity.self, from: data)
                    completion(.success(productResponseEntity))
                } catch {
                    completion(.failure(.decodingError))
                }
            }
        }.resume()
    }
}
